
fps_timer += (current_time-laststep)/1000;
window_set_caption("FPS: " + string(fps) + " - REAL: " + string(fps_real))
//show_debug_message("fps: "+string(fps_timer) + " / " + string((1/server_fps)));
if (fps_timer > 1/server_fps) {
	net_tick++;
	//show_debug_message("TICK"+string(net_tick));
	
	fps_timer = 0;


	/// Process inputs

		// client 1
		var msg = dst_receive(client_1.dst_out_queue);
		while (false != msg) {
			if (!is_array(msg)) {
				show_debug_message("SERVER Received a non-array message");
				break;
			}
			
			var out = applyInput(msg, client_1_x, client_1_y);
			client_1_x = out[0];
			client_1_y = out[1];
	
			client_1_last_processed_message = msg;
			msg = dst_receive(client_1.dst_out_queue);
		}

		// client 2
		var msg = dst_receive(client_2.dst_out_queue);
		while (false != msg) {
			if (!is_array(msg)) {
				show_debug_message("SERVER Received a non-array message");
				break;
			}
	
			var out = applyInput(msg, client_2_x, client_2_y);
			client_2_x = out[0];
			client_2_y = out[1];
	
			client_2_last_processed_message = msg;
			msg = dst_receive(client_2.dst_out_queue);
		}

	// Send updated world state to clients
	var world_packet = [];
	world_packet[e_state_packet.entity_id] = client_1.id;
	world_packet[e_state_packet.timestamp] = current_time;
	world_packet[e_state_packet.sequence] = client_1_last_processed_message[e_input_packet.sequence];
	world_packet[e_state_packet.x] = client_1_x;
	world_packet[e_state_packet.y] = client_1_y;
	dst_send(client_1.dst_in_queue, world_packet);
	dst_send(client_2.dst_in_queue, world_packet);
	
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

/// send world state

laststep = current_time;

room_speed = 20+random(120);
//room_speed = 15;