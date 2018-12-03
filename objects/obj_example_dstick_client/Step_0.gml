tick_timer += delta_time/1000000;
tick_frames ++;
//window_set_caption("FPS: " + string(fps) + " - REAL: " + string(fps_real))
//show_debug_message("fps: "+string(fps_timer) + " / " + string((1/server_fps)));

msec_duration = round(delta_time/1000);
forward = obj_example_dstick_main.input[dst_input.down] - obj_example_dstick_main.input[dst_input.up];
side = obj_example_dstick_main.input[dst_input.right] - obj_example_dstick_main.input[dst_input.left];
up = 0;
actions = 0;

//Client side prediction
var input_packet = [current_time, other.msec_duration, other.forward, other.side, other.up, other.actions];
ds_list_add(pending_inputs, input_packet);

with (obj_example_dstick_player) {
	applyInput([other.msec_duration, other.forward, other.side, other.up, other.actions]);
}

tosend_msec_duration += msec_duration;
tosend_forward += forward;
tosend_side += side;
tosend_up += up;
tosend_actions = 0;

if (tick_timer > 1/tickrate) {
	tick++;

	dsnet_create_packet(ds_client, dst_netmsg.c_input);
	dsnet_write(ds_client, buffer_u16, msec_interp);
	dsnet_write(ds_client, buffer_u16, tosend_msec_duration);
	dsnet_write(ds_client, buffer_u32, input_sequence);
	dsnet_write(ds_client, buffer_s16, (tosend_forward/tick_frames)*100);
	dsnet_write(ds_client, buffer_s16, (tosend_side/tick_frames)*100);
	dsnet_write(ds_client, buffer_s16, (tosend_up/tick_frames)*100);
	dsnet_write(ds_client, buffer_u8, tosend_actions);
	dsnet_send(ds_client);
	
	tosend_msec_duration = 0;
	tosend_forward = 0;
	tosend_side = 0;
	tosend_up = 0;
	tosend_actions = 0;

	input_sequence++;

	tick_timer = 0;
	tick_frames = 0;
}