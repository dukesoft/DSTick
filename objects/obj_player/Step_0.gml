now_ts = current_time;
dt_sec = (now_ts - last_ts);
last_ts = now_ts;

input[e_input.left] = keyboard_check(left);
input[e_input.right] = keyboard_check(right);
input[e_input.up] = keyboard_check(up);
input[e_input.down] = keyboard_check(down);

var input_packet = undefined;
input_packet = [];
input_packet[e_input_packet.timestamp] = now_ts;
input_packet[e_input_packet.entity_id] = id;
input_packet[e_input_packet.sequence] = dst_input_sequence_number;
input_packet[e_input_packet.left] = input[e_input.left];
input_packet[e_input_packet.right] = input[e_input.right];
input_packet[e_input_packet.up] = input[e_input.up];
input_packet[e_input_packet.down] = input[e_input.down];

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
		otherp_x = msg[e_state_packet.x];
		otherp_y = msg[e_state_packet.y];
	}
	
	msg = dst_receive(dst_in_queue);
}