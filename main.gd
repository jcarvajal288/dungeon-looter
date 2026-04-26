extends Node2D

@export var starting_room: PackedScene


func _ready() -> void:
	var room = starting_room.instantiate()
	$RoomManager.set_room(room)
	Global.bind_camera.emit(room.get_rect())
	Global.toggle_pause.connect(handle_pause)


func handle_pause(is_paused: bool) -> void:
	if is_paused:
		$Gameplay.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		$Gameplay.process_mode = Node.PROCESS_MODE_INHERIT


func add_room(room: Room) -> void:
	$Gameplay.add_child(room)
