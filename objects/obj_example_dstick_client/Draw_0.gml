if (!connected) {
	draw_text(room_width/2, room_height/2, "Trying to connect to " + server_ip + ":" + string(server_port) + string_repeat(".", get_timer()/200000 % 3));
} 

draw_set_halign(fa_left);
draw_set_color(c_white);
draw_text(300, 55, 
"Tickrate: " + string(tickrate) 
+ "\n" + "Tick: " + string(tick)
+ "\n" + "TTNT: " + string((1/tickrate) - tick_timer)
+ "\n" + "msec_interp: " + string(msec_interp)
+ "\n" + "Unprocessed inputs: " + string(ds_list_size(pending_inputs))
);