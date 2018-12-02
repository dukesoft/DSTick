
fps_timer += (current_time-laststep)/1000;
window_set_caption("FPS: " + string(fps) + " - REAL: " + string(fps_real))
//show_debug_message("fps: "+string(fps_timer) + " / " + string((1/server_fps)));
if (fps_timer > 1/server_fps) {
	net_tick++;
	//show_debug_message("TICK"+string(net_tick));
	
	fps_timer = 0;

	var max_time = current_time - laststep;
	var grace = max_time*0.05; // Some grace period to hold keys longer to account for lag and stuff
	/// Process inputs

		// client 1
		var msg = dst_receive(client_1.dst_out_queue);
		var pmaxtime = max_time + grace;

		while (false != msg) {
			if (!is_array(msg)) {
				show_debug_message("SERVER Received a non-array message");
				break;
			}

			pmaxtime -= msg[e_input_packet.duration];
			
			if (pmaxtime < 0) {
				show_debug_message("Invalid duration for player 1 ("+string(pmaxtime)+")");
				msg[e_input_packet.duration] += pmaxtime;
			}
			
			var out = applyInput(msg, client_1_x, client_1_y);
			client_1_x = out[0];
			client_1_y = out[1];
	
			client_1_last_processed_message = msg;
			msg = dst_receive(client_1.dst_out_queue);
		}

		// client 2
		var msg = dst_receive(client_2.dst_out_queue);
		var pmaxtime = max_time + grace;
		
		while (false != msg) {
			if (!is_array(msg)) {
				show_debug_message("SERVER Received a non-array message");
				break;
			}

			pmaxtime -= msg[e_input_packet.duration];
			
			if (pmaxtime < 0) {
				show_debug_message("Invalid duration for player 2 ("+string(pmaxtime)+")");
				msg[e_input_packet.duration] += pmaxtime;
			}
		
	
			var out = applyInput(msg, client_2_x, client_2_y);
			client_2_x = out[0];
			client_2_y = out[1];
	
			client_2_last_processed_message = msg;
			msg = dst_receive(client_2.dst_out_queue);
		}
	
	if (is_array(client_1_last_processed_message)) {
		// Send updated world state to clients
		var world_packet = [];
		world_packet[e_state_packet.entity_id] = client_1.id;
		world_packet[e_state_packet.timestamp] = current_time;
		world_packet[e_state_packet.sequence] = client_1_last_processed_message[e_input_packet.sequence];
		world_packet[e_state_packet.x] = client_1_x;
		world_packet[e_state_packet.y] = client_1_y;
		dst_send(client_1.dst_in_queue, world_packet);
		dst_send(client_2.dst_in_queue, world_packet);
	}
	
	if (is_array(client_2_last_processed_message)) {
		world_packet = undefined;
		world_packet = [];
		world_packet[e_state_packet.entity_id] = client_2.id;
		world_packet[e_state_packet.timestamp] = current_time;
		world_packet[e_state_packet.sequence] = client_2_last_processed_message[e_input_packet.sequence];
		world_packet[e_state_packet.x] = client_2_x;
		world_packet[e_state_packet.y] = client_2_y;
		dst_send(client_1.dst_in_queue, world_packet);
		dst_send(client_2.dst_in_queue, world_packet);
	}
	
	laststep = current_time;
}

/// send world state



//room_speed = 30+random(50);
room_speed = 60;