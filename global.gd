extends Node

var player: CharacterBody2D = null

enum RenderOrder {
	FLOOR = 1,
	WALL = 2,
	PLAYER = 5
}