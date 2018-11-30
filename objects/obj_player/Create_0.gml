image_blend = c_green;

default_fps = 60;

dst_out_queue = dst_queue_create_test(250);
dst_in_queue =  dst_queue_create_test(250);

inputs = [e_input.left, e_input.right, e_input.up, e_input.down];

input[e_input.left] = false;
input[e_input.right] = false;
input[e_input.up] = false;
input[e_input.down] = false;

previnput[e_input.left] = false;
previnput[e_input.right] = false;
previnput[e_input.up] = false;
previnput[e_input.down] = false;

timepressed[e_input.left] = 0;
timepressed[e_input.right] = 0;
timepressed[e_input.up] = 0;
timepressed[e_input.down] = 0;

dst_client_side_prediction = true;
dst_server_reconcilliation = true;
dst_entity_interpolation = true;

dst_input_sequence_number = 0;

update_rate = 50;

pending_inputs = ds_list_create();

otherp_inputs = ds_list_create();


now_ts = current_time;
last_ts = current_time;

otherp_x = -100;
otherp_y = -100;

x = 100;
y = 0;

keybind[e_input.left] = vk_left;
keybind[e_input.right] = vk_right;
keybind[e_input.up] = vk_up;
keybind[e_input.down] = vk_down;
