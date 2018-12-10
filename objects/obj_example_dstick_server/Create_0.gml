debug_log("[EXAMPLE] [SERVER] Server started!");

server = dsnet_server_create(
	8000,  //Port
	10, //Max connections
	
	//Handling functions
	dst_server_onconnect, 
	dst_server_ondisconnect,
	
	//The instance that will be spawned for a connected client
	obj_example_dstick_server_client
);

if (server == noone) {
	debug_log("[EXAMPLE] [SERVER] Server could not be started!");
	instance_destroy();
}

//Hook up custom events to the clients
dsnet_msghandle(dst_netmsg.c_info, dst_sr_info);
dsnet_msghandle(dst_netmsg.c_input, dst_sr_input);

tick = 0;
tick_timer = 0;

netlog_height = 50;
netlog = surface_create(window_get_width(), netlog_height);
netlog2 = surface_create(window_get_width(), netlog_height);
netlog_frame_width = 5;
netlog_max_width = window_get_width()/netlog_frame_width;

prepared_tick = ds_list_create(); //A random list of items to be added to next delta