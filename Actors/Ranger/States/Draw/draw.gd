extends State

@export var idle_state: State
@export var loose_state: State

signal fire_arrow


func process_frame(_delta: float) -> State:
	if director.interact:
		return idle_state
	elif not director.shoot:
		if animation_player.is_playing():
			return idle_state
		else:
			fire_arrow.emit()
			return loose_state
	return null
