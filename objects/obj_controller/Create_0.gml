enum e_input {
	left,
	right,
	up,
	down
}

enum e_input_packet {
	interpolation_time,
	duration,
	forward,
	side,
	up,
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