extends Node2D

@export var starting_room: PackedScene
@export var storage_box_screen: PackedScene


func _ready() -> void:
	var room = starting_room.instantiate()
	$RoomManager.set_room(room)
	add_child(storage_box_screen.instantiate())
	Global.bind_camera.emit(room.get_rect())
