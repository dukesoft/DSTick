///@param dst_queue
///@return bool

if (!instance_exists(argument0)) {
	return false;
}

return (argument0.object_index == __dst_testing_queue);
