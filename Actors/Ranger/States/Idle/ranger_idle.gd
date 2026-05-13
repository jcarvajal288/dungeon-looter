extends State

@export var move_state: State
@export var draw_state: State


func enter() -> void:
	super()
	subject.velocity = Vector2.ZERO


func process_frame(_delta: float) -> State:
	if director.movement_vector != Vector2.ZERO:
		return move_state
	elif director.shoot:
		return draw_state
	return null