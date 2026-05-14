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
	ITEM = 3,
	WALL = 4
}

@warning_ignore_start("unused_signal")
signal add_node_to_room(node: Node2D)
signal bind_camera(rect: Rect2)
signal toggle_pause(is_paused: bool)
signal transition_room(next_room_path: Node2D, entry_id: String)
signal unlock_door(door_id: String)
@warning_ignore_restore("unused_signal")

