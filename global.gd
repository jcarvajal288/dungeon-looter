extends Node

var player: CharacterBody2D = null

enum RenderOrder {
	FLOOR = 1,
	WALL = 2,
	PLAYER = 5
}

@warning_ignore_start("unused_signal")
signal bind_camera(rect: Rect2)
signal transition_room(next_room_path: Node2D, entry_id: String)
@warning_ignore_restore("unused_signal")