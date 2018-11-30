show_debug_overlay(true);
room_speed = 60;
laststep = current_time;
net_tick = 0;

server_fps = 4;
fps_timer = 0;

//using hard variables for test scenario - no real networking.
client_1 = obj_player;
client_2 = obj_other_player;

client_1_last_processed_input = 0;
client_2_last_processed_input = 0;

//Spawn points
client_1_x = 100;
client_1_y = 0;

client_2_x = 100;
client_2_y = 0;