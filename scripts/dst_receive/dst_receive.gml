///@description Read a message from a queue
///@param dst_queue
///@return array_dst_message

var dst_queue = argument0;

if (__dst_main.debug) {
	if (!__dst_is_queue_object(dst_queue)) return false;
}

if (ds_queue_empty(dst_queue.queue)) {
	return false;
}

var msg = ds_queue_head(dst_queue.queue);
if (msg[e_dst_queue_message.added] <= current_time) {
	ds_queue_dequeue(dst_queue.queue);
	return msg[e_dst_queue_message.message];
}

return false;