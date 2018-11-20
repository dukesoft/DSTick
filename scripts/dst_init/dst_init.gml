///Initialize

enum e_dst_queue_message {
	added,
	message
}

if (instance_exists(__dst_main)) {
	debug_log("DSTick: Tick System already initialized");
	return false;
}

instance_create_depth(0, 0, 0, __dst_main);

return true;