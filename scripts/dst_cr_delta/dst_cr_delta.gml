///@param buffer

// This is happening in obj_example_dsnet_client
var buffer = argument0;

// Read the tick number
var servertick = buffer_read(buffer, buffer_u32);

if (servertick == 0) {
	show_debug_message("Received initial gamestate, tick0");
}
last_received_tick = servertick;
//show_debug_message("Time since receiving last tick: " + string(current_time - time_last_received_tick));
time_last_received_tick = current_time;

if (!obj_example_dstick_main.tick_delay) {
	dst_process_tick(buffer, servertick);
} else {
	var bsize = buffer_get_size(buffer)-buffer_tell(buffer); //Current offset
	var newBuffer = buffer_create(bsize, buffer_fixed, 1);
	buffer_copy(buffer, buffer_tell(buffer), bsize, newBuffer, 0);
	ds_list_add(tick_queue, [servertick, current_time, newBuffer]);
}
