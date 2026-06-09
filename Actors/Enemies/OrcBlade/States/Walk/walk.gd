extends State

@export var idle_state: State
@export var attack_state: State


func process_frame(_delta: float) -> State:
	animation_player.set_facing(director.movement_vector)
	animation_player.play_with_facing(animation_name)
	if director.movement_vector == Vector2.ZERO:
		return idle_state
	elif subject.global_position.distance_to(Global.player.global_position) <= director.attack_distance:
		return attack_state
	subject.velocity = director.movement_vector * subject.speed
	subject.move_and_slide()
	return null