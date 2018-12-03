enum dst_input {
	left,
	right,
	up,
	down
}

keybind[dst_input.left] = ord("A");
keybind[dst_input.right] = ord("D");
keybind[dst_input.up] = ord("W");
keybind[dst_input.down] = ord("S");

input[dst_input.left] = false;
input[dst_input.right] = false;
input[dst_input.up] = false;
input[dst_input.down] = false;
