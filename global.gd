extends Node

var player: CharacterBody2D = null

enum RenderOrder {
	FLOOR = 1,
	WALL = 2,
	PLAYER = 5,
}

enum CollisionLayer {
	PLAYER = 1,
	ENEMY = 2,
	ITEM = 3
}

@warning_ignore_start("unused_signal")
signal bind_camera(rect: Rect2)
signal toggle_pause(is_paused: bool)
signal toggle_inventory_screen
signal transition_room(next_room_path: Node2D, entry_id: String)
@warning_ignore_restore("unused_signal")