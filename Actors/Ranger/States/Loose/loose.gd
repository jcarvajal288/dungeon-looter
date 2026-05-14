extends State

@export var idle_state: State

var arrow_scene: PackedScene = preload("res://Actors/Ranger/FlyingArrow/FlyingArrow.tscn")


func enter() -> void:
	var direction = director.movement_vector
	var arrow = arrow_scene.instantiate()
	arrow.direction = direction
	arrow.global_position = subject.global_position
	Global.add_node_to_room.emit(arrow)


func process_frame(_delta: float) -> State:
	if animation_player.is_playing():
		return null
	else:
		return idle_state
