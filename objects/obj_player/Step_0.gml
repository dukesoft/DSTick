now_ts = current_time;
dt_sec = (now_ts - last_ts);
last_ts = now_ts;



for (var i = 0; i < array_length_1d(inputs); i++) {
	var ev = inputs[i];
	
	input[i] = keyboard_check(keybind[i]);

	if (object_index == obj_other_player) {
		if (p2_moving) {
			if (i == e_input.right) {
				input[i] = true;
			}
			if (x > 500) {
				p2_moving = false;
			}
		} else {
			if (i == e_input.left) {
				input[i] = true;
			}
			if (x < 100) {
				p2_moving = true;
			}
		}
	}

	if (previnput[i] != input[i]) {
		previnput[i] = input[i];
		timepressed[i] = 0;
	}

	if (input[i]) {
		timepressed[i] = delta_time/1000;
		//show_debug_message("PRESSING " + string(i) + " FOR " + string(timepressed[i]));
	}
}

var input_packet = undefined;
input_packet = [];

input_packet[e_input_packet.interpolation_time] = interpolation_time;
input_packet[e_input_packet.duration] = delta_time/1000;
input_packet[e_input_packet.timestamp] = now_ts;
input_packet[e_input_packet.entity_id] = id;
input_packet[e_input_packet.sequence] = dst_input_sequence_number;
input_packet[e_input_packet.forward] = input[e_input.down] - input[e_input.up];
input_packet[e_input_packet.side] = input[e_input.right] - input[e_input.left];
input_packet[e_input_packet.up] = 0;

dst_input_sequence_number++;

dst_send(dst_out_queue, input_packet);

ds_list_add(pending_inputs, input_packet);

if (dst_client_side_prediction) {
	var out = applyInput(input_packet, x, y);
	x = out[0];
	y = out[1];
}

var msg = dst_receive(dst_in_queue);
while (false != msg) {
	if (!is_array(msg)) {
		show_debug_message("Received a non-array message");
		break;
	}

	if (string(msg[e_state_packet.entity_id]) == string(id.id)) { //lol @ game maker - ID doesnt work (thats -4). id.id == real instance ID. YOU GO GAME MAKER.
		x = msg[e_state_packet.x];
		y = msg[e_state_packet.y];
		
		if (dst_server_reconcilliation) {
			var i = 0;
			while (i < ds_list_size(pending_inputs)) {
				var pinput = pending_inputs[| i];
				if (pinput[e_input_packet.sequence] <= msg[e_state_packet.sequence]) {
					interpolation_time = current_time - pinput[e_input_packet.timestamp];
					ds_list_delete(pending_inputs, i);
				} else {
					var out = applyInput(pinput, x, y);
					x = out[0];
					y = out[1];
					i++;
				}
			}
		} else {
			ds_list_clear(pending_inputs);
		}
	} else {
		if (dst_entity_interpolation) {
			ds_list_add(otherp_inputs, [current_time, msg]);
		} else {
			otherp_x = msg[e_state_packet.x];
			otherp_y = msg[e_state_packet.y];
		}
		
	}
	
	msg = dst_receive(dst_in_queue);
}

if (dst_entity_interpolation && ds_list_size(otherp_inputs) >= 2) {
	var newest = otherp_inputs[| 0];
	var render_timestamp = current_time - 1000/obj_server.server_fps;
	while (ds_list_size(otherp_inputs) > 2 && newest[0] <= render_timestamp) {
		ds_list_delete(otherp_inputs, 0);
		//show_debug_message("Oldest: " + string(otherp_inputs[| 0]));
		//show_debug_message("Newest: " + string(otherp_inputs[| 1]));
		newest = otherp_inputs[| 0];
	}
	
	var oldest = otherp_inputs[| 1];
	
	var newestmsg = newest[1];
	var oldestmsg = oldest[1];
	
	var x0 = oldestmsg[e_state_packet.x];
	var x1 = newestmsg[e_state_packet.x];
	
	var y0 = oldestmsg[e_state_packet.y];
	var y1 = newestmsg[e_state_packet.y];
	
	var t0 = oldest[0];
	var t1 = newest[0];
	
	var interp_position = (((render_timestamp - t0) / (t1-t0))-1);
	
	otherp_x = x0 + (x1 - x0) * interp_position;
	otherp_y = y0 + (y1 - y0) * interp_position;
	
	//show_debug_message("X0: " + string(x0) + ", X1: " + string(x1) + " | " + string(render_timestamp) + " - " + string(t0) + " ("+string(render_timestamp - t0)+") / "+string(t1)+"/"+string(t0)+" ("+string(t1-t0)+") ["+string(interp_position)+"]");
	
}

//show_debug_message("Size: " + string(ds_list_size(otherp_inputs)));