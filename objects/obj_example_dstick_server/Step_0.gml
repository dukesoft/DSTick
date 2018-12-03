tick_timer += delta_time/1000000;
//window_set_caption("FPS: " + string(fps) + " - REAL: " + string(fps_real))
//show_debug_message("fps: "+string(fps_timer) + " / " + string((1/server_fps)));

if (tick_timer > 1/tickrate) {
	surface_set_target(netlog);
		draw_set_color(c_black);
		draw_rectangle(0, 0, netlog_frame_width, netlog_height, 0);
	surface_reset_target();
	tick++;

	

	tick_timer = 0;
}