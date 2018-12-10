if (obj_example_dstick_main.entity_interpolation && ds_list_size(positions) >= 2) {
	var newest = positions[| 0];
	var render_timestamp = current_time - 1000/obj_example_dstick_client.server_tickrate;
	while (ds_list_size(positions) > 2 && newest[0] <= render_timestamp) {
		ds_list_delete(positions, 0);
		
		show_debug_message("Now: " + string(current_time));
		show_debug_message("Renderts: " + string(render_timestamp));
		show_debug_message("Oldest: " + string(positions[| 0]));
		show_debug_message("Newest: " + string(positions[| 1]));
		newest = positions[| 0];
	}
	
	var oldest = positions[| 1];
	
	var x0 = oldest[1];
	var x1 = newest[1];
	
	var y0 = oldest[2];
	var y1 = newest[2];
	
	var t0 = oldest[0];
	var t1 = newest[0];
	
	var interp_position = (((render_timestamp - t0) / (t1-t0)));
	
	x = x0 + (x1 - x0) * interp_position;
	y = y0 + (y1 - y0) * interp_position;
	
	show_debug_message("Target: " + string(x0) + ", Old: " + string(x1) + " Cur: "+string(x)+" | " + string(render_timestamp) + " - " + string(t0) + " ("+string(render_timestamp - t0)+") / "+string(t1)+"/"+string(t0)+" ("+string(t1-t0)+") ["+string(interp_position)+"]");
	
}