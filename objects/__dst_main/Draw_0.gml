draw_set_color(c_white);
draw_set_font(fnt_dstick_debug);
draw_text(
	200, 
	200, 
	"get_timer: " + string(get_timer()) + "\n"
	+ "get_timer (ms): " + string(get_timer()/1000) + "\n"
	+ "get_timer (seconds): " + string(get_timer()/1000000) + "\n"
	+ "\n"
	+ "current_time (ms): " + string(current_time) + "\n"
	+ "current_time (s): " + string(current_time/1000) + "\n"
);