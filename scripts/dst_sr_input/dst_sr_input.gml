///@param buffer

// This is happening in obj_example_dsnet_server_client
var buffer = argument0;

with (obj_example_dstick_server) {
	surface_set_target(netlog);
		draw_set_color(make_color_hsv(other.hue, 196, 196));
		draw_rectangle(0, netlog_height/5, netlog_frame_width, netlog_height, 0);
	surface_reset_target();
}

msec_interp = buffer_read(buffer, buffer_u16);
msec_duration = buffer_read(buffer, buffer_u16)/100;
input_sequence = buffer_read(buffer, buffer_u32);
forward = buffer_read(buffer, buffer_s16)/100;
side = buffer_read(buffer, buffer_s16)/100;
up = buffer_read(buffer, buffer_s16)/100;
actions = buffer_read(buffer, buffer_u8); // Up to 8 action buttons pressed

var inpmsg = [msec_duration, forward, side, up, actions];
applyInput(inpmsg);