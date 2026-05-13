extends State

@export var idle_state: State
@export var draw_state: State


func process_frame(_delta: float) -> State:
	animation_player.set_facing(director.movement_vector)
	animation_player.play_with_facing(animation_name)
	if director.movement_vector == Vector2.ZERO:
		return idle_state
	elif director.shoot:
		return draw_state
	subject.velocity = director.movement_vector * subject.speed
	subject.move_and_slide()
	return null