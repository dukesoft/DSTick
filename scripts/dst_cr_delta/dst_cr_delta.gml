///@param buffer

// This is happening in obj_example_dsnet_client
var buffer = argument0;

// Read the tick number

var servertick = buffer_read(buffer, buffer_u32);

if (servertick == 0) {
	show_debug_message("Received initial gamestate, tick0");
}

var msginfo = buffer_read(buffer, buffer_u8);
while (msginfo != 254) { //end of packet
	switch (msginfo) {
		#region player location smooth
		case dst_delta.playerpos: //Player location
			var pid = buffer_read(buffer, buffer_u16);
			var last_input_sequence = buffer_read(buffer, buffer_u32);
			var xx = buffer_read(buffer, buffer_u16);
			var yy = buffer_read(buffer, buffer_u16);
			var rplayer = undefined;
			
			if (pid == mp_id) {
				rplayer = player;
				
				//This is us (this is us)
				// so lets remove our unprocessed inputs up until this tick and add everything (server_reconcilliation)
				
				rplayer.x = xx;
				rplayer.y = yy;
				
				if (obj_example_dstick_main.server_reconcilliation) {
					var i = 0;

					while (i < ds_list_size(pending_inputs)) {
						var pinput = pending_inputs[| i];
						if (pinput[1] <= last_input_sequence) {
							// Already handled!
							ds_list_delete(pending_inputs, i);
						} else {
							//Re apply the input because this one wasn't handled by the server yet
							with (rplayer) {
								applyInput([pinput[2], pinput[3], pinput[4], pinput[5]]);
							}
							i++;
						}
					}					
				} else {
					ds_list_clear(pending_inputs);
				}
			} else {
				rplayer = clients[? pid];
			
				if (rplayer == undefined || !instance_exists(rplayer)) {
					debug_log("Received player packet for unknown client: " + string(pid));
					break;
				}
				
				if (obj_example_dstick_main.entity_interpolation) {
					ds_list_add(rplayer.positions, [current_time, xx, yy]);
				} else {
					rplayer.x = xx;
					rplayer.y = yy;
				}
			}
			break;
		#endregion
		
		#region playerjoin
		case dst_delta.playerjoin:
			var pid = buffer_read(buffer, buffer_u16);
			var hue = buffer_read(buffer, buffer_u8);
			var username = buffer_read(buffer, buffer_string);
			
			if (pid == mp_id) {
				debug_log("Skipping own information");
				break;
			}
			
			var op = instance_create_depth(0, 0, 0, obj_example_dstick_otherplayer);
			op.hue = hue;
			op.username = username;
			op.mp_id = pid;
			op.active = true;
			
			with (op) {event_user(0); }
			clients[? pid] = op;
			break;
		#endregion
		
		#region playerleft
		case dst_delta.playerleave:
			var pid = buffer_read(buffer, buffer_u16);

			if (pid == mp_id) {
				debug_log("OWN LEFT - Maybe kick?");
				break;
			}
			
			var rplayer = clients[? pid];

			if (rplayer == undefined || !instance_exists(rplayer)) {
				debug_log("Received player packet for unknown client: " + string(pid));
				break;
			}
			instance_destroy(rplayer);
			break;
		#endregion
			
		default:
			debug_log("Unhandled type in delta: " + string(msginfo) + " - SKIPPING DELTA");
			return 0;
			break;
	}

	msginfo = buffer_read(buffer, buffer_u8);
}