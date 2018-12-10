if (!connected) {
	draw_text(room_width/2, room_height/2, "Trying to connect to " + server_ip + ":" + string(server_port) + string_repeat(".", get_timer()/200000 % 3));
} 

draw_set_halign(fa_left);
draw_set_color(c_white);
draw_text(300, 55, 
"Inputrate: " + string(obj_example_dstick_main.input_rate) 
+ "\n" + "Input Sequence: " + string(input_sequence)
+ "\n" + "TTNT: " + string((1/obj_example_dstick_main.input_rate) - input_timer)
+ "\n" + "msec_interp: " + string(msec_interp) + " ( "+string(server_tickrate*(msec_interp/1000))+" ticks)"
+ "\n" + "Unprocessed inputs: " + string(ds_list_size(pending_inputs))

+ "\n" + "NET IN: " + string(ds_client.packets_received_last_second) + "p/s @ " + string(ds_client.bytes_received_last_second/1024) + "kb/s" 
+ "\n" + "   OUT: " + string(ds_client.packets_sent_last_second) + "p/s @ " + string(ds_client.bytes_sent_last_second/1024) + "kb/s" 

);