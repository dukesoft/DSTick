draw_sprite_ext(sprite_index, 0, round(x), round(y), 1, 1, 0, image_blend, 1);
draw_set_valign(fa_top);
draw_set_halign(fa_center);
draw_text(round(x), round(y)+16, obj_example_dstick_client.username + " (You!) \n" + string(obj_example_dstick_client.mp_id));