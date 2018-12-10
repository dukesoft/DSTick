tick_timer += delta_time/1000000;
//window_set_caption("FPS: " + string(fps) + " - REAL: " + string(fps_real))
//show_debug_message("fps: "+string(fps_timer) + " / " + string((1/server_fps)));

if (tick_timer > 1/obj_example_dstick_main.tick_rate) {
	/*
	surface_set_target(netlog);
		draw_set_color(c_black);
		draw_rectangle(0, 0, netlog_frame_width, netlog_height, 0);
	surface_reset_target();
	*/
	tick++;

	dsnet_create_packet(server, dst_netmsg.s_delta);
	dsnet_write(server, buffer_u32, tick);
	
	// First write all info from prepared ticks (e.g. joining / leaving
	
	while (ds_list_size(prepared_tick) > 0) {
		var item = prepared_tick[| 0];
		switch (item[0]) {
			case dst_delta.playerjoin:
				var player = item[1];
				dsnet_write(server, buffer_u8, dst_delta.playerjoin); // Player location
				dsnet_write(server, buffer_u16, player.dsnet_client.socket); // Player ID
				dsnet_write(server, buffer_u8, player.hue);
				dsnet_write(server, buffer_string, player.username);
				break;
			case dst_delta.playerleave:
				dsnet_write(server, buffer_u8, dst_delta.playerleave); // Player location
				dsnet_write(server, buffer_u16, item[1]); // Old pid (instance is already destroyed)
				break;			
			default:
				debug_log("Unknown prepared tick message: " + string(item[0]));
				break;
		}
		
		ds_list_delete(prepared_tick, 0);
	}
	
	
	// Write player locations that have changed
	with (obj_example_dstick_server_client) {
		dsnet_write(other.server, buffer_u8, dst_delta.playerpos); // Player location
		dsnet_write(other.server, buffer_u16, dsnet_client.socket); // Player ID
		
		dsnet_write(other.server, buffer_u32, input_sequence); // Latest performed input sequence
		
		dsnet_write(other.server, buffer_u16, x);
		dsnet_write(other.server, buffer_u16, y);
	}
	
	dsnet_write(other.server, buffer_u8, 254); // End of packet
	
	dsnet_send_all(server);

	tick_timer = 0;
}