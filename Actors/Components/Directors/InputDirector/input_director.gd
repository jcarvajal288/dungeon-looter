extends Director

@onready var interact: bool = false
@onready var shoot_just_pressed: bool = false
@onready var shoot_held: bool = false


func _physics_process(_delta: float) -> void:
	reset()
	var mv = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	movement_vector = Vector2(
		snapped(mv.x, 0.5), 
		snapped(mv.y, 0.5)
	).normalized()
	interact = Input.is_action_just_pressed("interact")
	shoot_just_pressed = Input.is_action_just_pressed("shoot")
	shoot_held = Input.is_action_pressed("shoot")
