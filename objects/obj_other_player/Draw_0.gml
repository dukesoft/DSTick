draw_set_color(image_blend);
draw_self();
draw_text(50, ystart+64, "Queue size: " + string(ds_queue_size(dst_queue.queue)))