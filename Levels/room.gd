class_name Room extends Node2D

const MAP_TILE_SIZE = 16


func _ready() -> void:
	var room_rect = $TileMapFloor.get_used_rect()
	var pos = room_rect.position * MAP_TILE_SIZE
	var size = room_rect.size * MAP_TILE_SIZE
	Global.bind_camera.emit(Rect2(pos, size))
	Global.player.get_node("CollisionShape2D").set_deferred("disabled", false)


func get_entry_point(_entry_id: String) -> Vector2:
	printerr("No get_entry_point defined for room")
	return Vector2.ZERO


func get_rect() -> Rect2:
	var room_rect = $TileMapFloor.get_used_rect()
	var pos = room_rect.position * MAP_TILE_SIZE
	var size = room_rect.size * MAP_TILE_SIZE
	return Rect2(pos, size)
