extends Node2D


func _ready() -> void:
	Global.bind_camera.emit($TestRoom.get_rect())

