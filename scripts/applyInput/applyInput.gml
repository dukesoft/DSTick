///@param input
var input = argument0;
var in_x = argument1;
var in_y = argument2;

if (!is_array(input)) {
	show_error("Input must be an array", true);
}

var spd = 4; // per frame at 60fps

var spdpersec = 60*spd; //240 / second

var extx = spdpersec * ((input[e_input_packet.right]-input[e_input_packet.left]))/1000;
var exty = spdpersec * ((input[e_input_packet.down]-input[e_input_packet.up]))/1000;

//show_debug_message("MOVING " + string(extx) + " PER FRAME");


in_x += extx
in_y += exty

return [in_x, in_y];