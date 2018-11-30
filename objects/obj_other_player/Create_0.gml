event_inherited();
image_blend = c_red;
dst_out_queue = dst_queue_create_test(1000);
dst_in_queue = dst_queue_create_test(1000);

keybind[e_input.left] = ord("A");
keybind[e_input.right] = ord("D");
keybind[e_input.up] = ord("W");
keybind[e_input.down] = ord("S");
