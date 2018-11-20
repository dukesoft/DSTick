///@description Destroy a queue
///@param ds_queue
if (__dst_main.debug) {
	if (!__dst_is_queue_object(argument0)) return false;
}

instance_destroy(argument0);
return true;