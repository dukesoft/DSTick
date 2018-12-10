///@param buffer

// This is happening in obj_example_dsnet_client
var buffer = argument0;

mp_id = buffer_read(buffer, buffer_u16);
server_tickrate = buffer_read(buffer, buffer_u8);
tick = buffer_read(buffer, buffer_u32);

tick_delay = (msec_interp/1000) * server_tickrate;
current_processing_tick = tick-tick_delay;
last_received_tick = tick;

// Now create our own player
player = instance_create_depth(0, 0, 0, obj_example_dstick_player);