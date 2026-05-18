extends Label


func start() -> void:
	pivot_offset = size / 2
	z_index = Global.RenderOrder.PLAYER + 1
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "global_position:y", global_position.y - 12, 0.7) \
		.set_trans(Tween.TRANS_QUART) \
		.set_ease(Tween.EASE_OUT)
	tween.chain().tween_callback(queue_free)