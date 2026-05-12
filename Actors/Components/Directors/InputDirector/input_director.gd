extends Director


func _physics_process(_delta: float) -> void:
	reset()
	var mv = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	movement_vector = Vector2(
		snapped(mv.x, 0.5), 
		snapped(mv.y, 0.5)
	).normalized()
