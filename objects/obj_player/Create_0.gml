image_blend = c_lime;
dst_out_queue = dst_queue_create_test(250);
dst_in_queue =  dst_queue_create_test(250);

input[e_input.left] = false;
input[e_input.right] = false;
input[e_input.up] = false;
input[e_input.down] = false;

dst_client_side_prediction = true;
dst_server_reconcilliation = true;
dst_entity_interpolation = true;

dst_input_sequence_number = 0;

update_rate = 50;

pending_inputs = ds_list_create();

now_ts = current_time;
last_ts = current_time;

otherp_x = -100;
otherp_y = -100;

x = 100;
y = 0;

left = vk_left;
right = vk_right;
up = vk_up;
down = vk_down;