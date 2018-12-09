tick_timer += delta_time/1000000;
//window_set_caption("FPS: " + string(fps) + " - REAL: " + string(fps_real))
//show_debug_message("fps: "+string(fps_timer) + " / " + string((1/server_fps)));

if (tick_timer > 1/tickrate) {
	surface_set_target(netlog);
		draw_set_color(c_black);
		draw_rectangle(0, 0, netlog_frame_width, netlog_height, 0);
	surface_reset_target();
	tick++;

	dsnet_create_packet(server, dst_netmsg.s_delta);
	dsnet_write(server, buffer_u32, tick);
	
	// Write player locations that have changed
	with (obj_example_dstick_server_client) {
		dsnet_write(other.server, buffer_u8, 0); // Player location
		dsnet_write(other.server, buffer_u16, dsnet_client.socket); // Player ID
		
		dsnet_write(other.server, buffer_u32, input_sequence); // Latest performed input sequence
		
		dsnet_write(other.server, buffer_u16, x);
		dsnet_write(other.server, buffer_u16, y);
	}
	
	dsnet_write(other.server, buffer_u8, 254); // End of packet
	
	dsnet_send_all(server);

	tick_timer = 0;
}