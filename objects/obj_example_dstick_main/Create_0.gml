//Setup DSNET
dsnet_init();
dsnet_draw_debug(false); // Draws information about connections
dsnet_debug(false); // Debug logs
dsnet_verbose(false); // Extra logging information
dsnet_message_log(false); //Logs eachs incoming message (external)

dsnet_non_blocking(true); //Default on true

room_speed = 60;

// Now we set up our custom messages. As this can differ per server / client, we hook them up in the actual server and client.
// But to keep things simple and ordered (so that message ID's don't clash), we use 1 single ENUM, that we create here

enum dst_netmsg {
	c_info, //Client sends info to server
	s_main, //Server sends info to client
	
	// Since DSNET is setup very abstract, (e.g. multi-level servers etc.) we setup clients joining and hosting on our own, using delta's
	c_input, //Client sends its input
	s_delta, //Server sends a delta
}

enum dst_delta {
	playerpos,
	playerjoin,
	playerleave,
}

//Now for some generic game settings
player_speed = 4; //4*room_speed pixels per frame (so usually 4*60 per second)

//Now randomize so we all have random colours
randomize();

initInput();

input_prediction = true;
server_reconcilliation = true;
entity_interpolation = true;

tick_delay = true;

input_rate = 8;
tick_rate = 16;

max_delta_size = 1500; //Bytes
max_interpolation_time = 4000; //Milliseconds (in case is 128 tick, 512 ticks)

room_speed = 60;