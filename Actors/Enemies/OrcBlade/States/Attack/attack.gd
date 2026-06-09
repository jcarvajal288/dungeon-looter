extends State

@export var idle_state: State


func enter() -> void:
	super()
	subject.velocity = Vector2.ZERO


func process_frame(_delta: float) -> State:
	if animation_player.is_playing():
		return null
	else:
		return idle_state