enum e_input {
	left,
	right,
	up,
	down
}

enum e_input_packet {
	left,
	right,
	up,
	down,
	sequence,
	entity_id,
	timestamp
}

enum e_state_packet {
	x,
	y,
	sequence,
	entity_id,
	timestamp
}

dst_init();