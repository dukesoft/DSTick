//server_ip = "145.131.24.156"; //it hurts when IP
server_ip = "127.0.0.1"; //it hurts when IP
server_port = 8000;

username = "User " + string(round(random(8999)+1000));
hue = real(random(255));
mp_id = 0; //We receive this from the server

// A map to store all other players' instances
clients = ds_map_create();

//Start up DSNet
ds_client = noone; //In case of a blocking connect, the function call can immediately destroy the client after creating. To prevent "unknown instance" errors, we set this to noone first.
ds_client = dsnet_client_create(
	server_ip, 
	server_port,

	//these functions are executed in context of this object once they happen
	dst_client_onconnect, 
	dst_client_ondisconnect
);

// Map the messages
dsnet_msghandle(dst_netmsg.s_main, dst_cr_main);
dsnet_msghandle(dst_netmsg.s_delta, dst_cr_delta);

input_timer = 0;
input_frames = 0;
input_sequence = 0;

msec_duration = 0;
forward = 0;
side = 0;
up = 0;
actions = 0;

tosend_msec_duration = 0;
tosend_forward = 0;
tosend_side = 0;
tosend_up = 0;
tosend_actions = 0;

msec_interp = 2000;
server_tickrate = 1;

pending_inputs = ds_list_create();
//Max interpolation time (e.g. 1000msec/1000 * 128 tick (high tickrate) = max amount of ticks to store)
tick_queue = ds_list_create(); //[TICK, TIME, BUFFER]

tick_timer = 0;

tick_delay = 0;
current_processing_tick = 0;
last_received_tick = 0;
time_last_received_tick = current_time;