if (keyboard_check(vk_space)) {
	dst_send(dst_queue, ["test"]);
}

var msg = dst_receive(dst_queue);
if (false != msg) {
	show_debug_message("    Received: " + string(msg));
}