///@param input
var input = argument0; //msec_duration, forward, side, up, actions

if (!is_array(input)) {
	show_error("Input must be an array", true);
}

var spdpersec = 60*obj_example_dstick_main.player_speed; //240 / second

var spdforthispacket = (spdpersec/1000) * input[0];

y += spdforthispacket * input[1]; //forward
x += spdforthispacket * input[2]; //side