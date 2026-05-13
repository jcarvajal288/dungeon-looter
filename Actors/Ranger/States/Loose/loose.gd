extends State

@export var idle_state: State


func process_frame(_delta: float) -> State:
	if animation_player.is_playing():
		return null
	else:
		return idle_state