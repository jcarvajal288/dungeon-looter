extends Node

var player: CharacterBody2D = null

enum RenderOrder {
	FLOOR = 1,
	WALL = 2,
	PLAYER = 5
}

@warning_ignore_start("unused_signal")
signal bind_camera(rect: Rect2)
@warning_ignore_restore("unused_signal")