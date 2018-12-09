///@param buffer

// This is happening in obj_example_dsnet_client
var buffer = argument0;

// Read the tick number

var servertick = buffer_read(buffer, buffer_u32);

var msginfo = buffer_read(buffer, buffer_u8);
while (msginfo != 254) { //end of packet
	switch (msginfo) {
		case 0: //Player location
			
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
					debug_log("Interp time: " + string(interpolation_time));
					
				} else {
					ds_list_clear(pending_inputs);
				}
			} else {
				rplayer = clients[? pid];
			
				if (rplayer == undefined || !instance_exists(rplayer)) {
					debug_log("Received player packet for unknown client: " + string(pid));
					break;
				}
				
				rplayer.x = xx;
				rplayer.y = yy;
			}
			break;
	}

	msginfo = buffer_read(buffer, buffer_u8);
}