///@description Send a message to a queue
///@param dst_queue
///@param message

var dst_queue = argument0;
var message = argument1;

if (__dst_main.debug) {
	if (!__dst_is_queue_object(dst_queue)) return false;
	
	if (!dst_is_message(message)) {
		debug_log("DSTICK: Message " + string(message) + " is not a valid queue message");
		return false;
	}
}

var lag = 0;
if (dst_is_testing_queue(dst_queue)) {
	lag = dst_queue.lag;
}

ds_queue_enqueue(dst_queue.queue, [lag + current_time, message]);
return true;