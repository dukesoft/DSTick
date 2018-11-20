///@param dst_queue

var dst_queue = argument0;

if (!instance_exists(dst_queue)) {
	debug_log("DSTICK: Queue " + string(dst_queue) + " does not exist!");
	return false;
}
if (dst_queue.object_index != __dst_testing_queue && dst_queue.object_index != __dst_queue) {
	debug_log("DSTICK: Queue " + string(dst_queue) + " is not a valid queue object, but a " + string(object_get_name(dst_queue.object_index)));
	return false;
}
return true;