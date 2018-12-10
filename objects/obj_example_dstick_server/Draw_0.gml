/*
surface_set_target(netlog2);
	draw_clear(c_white);
	draw_surface(netlog, netlog_frame_width, 0);
surface_reset_target();

surface_set_target(netlog);
	draw_surface(netlog2, 0, 0);
surface_reset_target();


draw_surface_ext(netlog, window_get_width(), 0, -1, 1, 0, c_white, 0.5);
*/

draw_set_halign(fa_left);
draw_set_color(c_white);
draw_text(10, 55, 
"Tickrate: " + string(obj_example_dstick_main.tick_rate) 
+ "\n" + "Tick: " + string(tick)
+ "\n" + "TTNT: " + string((1/obj_example_dstick_main.tick_rate) - tick_timer)

+ "\n" + "NET IN: " + string(server.packets_received_last_second) + "p/s @ " + string(server.bytes_received_last_second/1024) + "kb/s" 
+ "\n" + "   OUT: " + string(server.packets_sent_last_second) + "p/s @ " + string(server.bytes_sent_last_second/1024) + "kb/s" 

);