extends CharacterBody2D


func _physics_process(_delta: float) -> void:
	move()


func get_movement_vector() -> Vector2:
	var mv = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var snapped_vector = Vector2(
		snapped(mv.x, 0.5), 
		snapped(mv.y, 0.5)
	).normalized()
	return snapped_vector


func move() -> void:
	var movement_vector = get_movement_vector()
	velocity = movement_vector * 20
	move_and_slide()