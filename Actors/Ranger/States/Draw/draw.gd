extends State

@export var idle_state: State
@export var loose_state: State

signal fire_arrow

var has_ammo_left = true


func enter() -> void:
	super()
	has_ammo_left = Global.player.has_ammo_left()
	if not has_ammo_left:
		Global.player.spawn_toast("No arrows left!")
		animation_player.pause()


func process_frame(_delta: float) -> State:
	if director.interact:
		return idle_state
	elif not director.shoot_held:
		if not has_ammo_left or animation_player.is_playing():
			return idle_state
		else:
			fire_arrow.emit()
			return loose_state
	return null