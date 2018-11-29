draw_set_color(image_blend);
draw_sprite_ext(sprite_index, 0, x, y+ystart, 1, 1, 0, image_blend, 1);
draw_text(50, ystart+64, "Queue size: " + string(ds_queue_size(dst_out_queue.queue))+ "\nUnprocessed inputs: " + string(ds_list_size(pending_inputs)));

othercolor = c_red;
if (image_blend == c_red) {
	othercolor = c_green;	
}
draw_sprite_ext(sprite_index, 0, otherp_x, otherp_y+ystart, 1, 1, 0, othercolor, 1);