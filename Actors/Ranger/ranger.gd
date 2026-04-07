class_name Ranger extends CharacterBody2D

const speed = 80

var facing = "SouthEast"

func _ready() -> void:
	Global.player = self
	z_index =  Global.RenderOrder.PLAYER


func _physics_process(_delta: float) -> void:
	var movement_vector = get_movement_vector()
	move(movement_vector)
	animate(movement_vector)


func get_movement_vector() -> Vector2:
	var mv = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var snapped_vector = Vector2(
		snapped(mv.x, 0.5), 
		snapped(mv.y, 0.5)
	).normalized()
	return snapped_vector


func move(movement_vector: Vector2) -> void:
	velocity = movement_vector * speed
	move_and_slide()


func animate(movement_vector: Vector2) -> void:
	if movement_vector == Vector2.ZERO:
		$AnimationPlayer.play("idle" + facing)
	else:
		facing = determine_facing(movement_vector)
		$AnimationPlayer.play("walk" + facing)


func determine_facing(direction: Vector2) -> String:
	if direction.x >= 0:
		if direction.y >= 0:
			return "SouthEast"
		else:
			return "NorthEast"
	elif direction.x < 0:
		if direction.y >= 0:
			return "SouthWest"
		else:
			return "NorthWest"
	else:
		return facing
