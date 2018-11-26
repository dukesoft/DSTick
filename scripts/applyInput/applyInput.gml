///@param input
var input = argument0;
var in_x = argument1;
var in_y = argument2;

if (!is_array(input)) {
	show_error("Input must be an array", true);
}

in_x += 4*(input[e_input_packet.right]-input[e_input_packet.left])
in_y += 4*(input[e_input_packet.down]-input[e_input_packet.up])

return [in_x, in_y];