extends State

@export var idle_state: State


func process_frame(_delta: float) -> State:
	if not animation_player.is_playing():
		return idle_state
	return null