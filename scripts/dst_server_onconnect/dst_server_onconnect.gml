// This is happening in a connected client [obj_example_dsnet_server_client]
debug_log("[EXAMPLE] [SERVER] Client ("+string(id)+") joined from " + string(dsnet_client.ip));

//Add to next tick
with (server.parent) {
	ds_list_add(prepared_tick, [dst_delta.playerjoin, other.id]);
}
