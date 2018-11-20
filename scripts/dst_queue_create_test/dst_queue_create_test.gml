///@description Create a testing queue
///@param ms_lag

var inst = instance_create_depth(0, 0, 0, __dst_testing_queue);
inst.lag = argument0;

return inst;