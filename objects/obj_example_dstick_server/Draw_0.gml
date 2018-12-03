surface_set_target(netlog2);
	draw_clear(c_white);
	draw_surface(netlog, netlog_frame_width, 0);
surface_reset_target();

surface_set_target(netlog);
	draw_surface(netlog2, 0, 0);
surface_reset_target();


draw_surface_ext(netlog, window_get_width(), 0, -1, 1, 0, c_white, 0.5);
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_text(10, 55, 
"Tickrate: " + string(tickrate) 
+ "\n" + "Tick: " + string(tick)
+ "\n" + "TTNT: " + string((1/tickrate) - tick_timer)

);