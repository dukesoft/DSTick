// This is happening in a connected client [obj_example_dsnet_server_client]
debug_log("[EXAMPLE] [SERVER] Client "+string(id)+" disconnected");

// Add to next tick
with (server.parent) {
	ds_list_add(prepared_tick, [dst_delta.playerleave, other.dsnet_client.socket]);
}