if (!ds_client.connected) {
	//Skip if we're not connected yet
	return 0;
}

input_timer += delta_time/1000000;
input_frames ++;
//window_set_caption("FPS: " + string(fps) + " - REAL: " + string(fps_real))
//show_debug_message("fps: "+string(fps_timer) + " / " + string((1/server_fps)));

msec_duration = round(delta_time/1000);
forward = obj_example_dstick_main.input[dst_input.down] - obj_example_dstick_main.input[dst_input.up];
side = obj_example_dstick_main.input[dst_input.right] - obj_example_dstick_main.input[dst_input.left];
up = 0;
actions = 0;

tosend_msec_duration += msec_duration;
tosend_forward += forward*msec_duration;
tosend_side += side*msec_duration;
tosend_up += up*msec_duration;
tosend_actions = 0;

var input_packet = [current_time, input_sequence, forward*msec_duration, side*msec_duration, up*msec_duration, actions];
ds_list_add(pending_inputs, input_packet);

if (obj_example_dstick_main.input_prediction) {
	with (obj_example_dstick_player) {
		applyInput([input_packet[2], input_packet[3], input_packet[4], input_packet[5]]);
	}
}

if (input_timer > 1/obj_example_dstick_main.input_rate) {

	dsnet_create_packet(ds_client, dst_netmsg.c_input);
	dsnet_write(ds_client, buffer_u16, msec_interp);
	dsnet_write(ds_client, buffer_u16, tosend_msec_duration*100);
	dsnet_write(ds_client, buffer_u32, input_sequence);
	dsnet_write(ds_client, buffer_s16, tosend_forward);
	dsnet_write(ds_client, buffer_s16, tosend_side);
	dsnet_write(ds_client, buffer_s16, tosend_up);
	dsnet_write(ds_client, buffer_u8, tosend_actions);
	dsnet_send(ds_client);

	tosend_msec_duration = 0;
	tosend_forward = 0;
	tosend_side = 0;
	tosend_up = 0;
	tosend_actions = 0;

	input_sequence++;

	input_timer = 0;
	input_frames = 0;
}