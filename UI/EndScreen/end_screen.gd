extends CanvasLayer

@export var storage: Inventory

signal end_game

@onready var score = $Control/VBoxContainer/Score

func _ready() -> void:
	$Control.visible = false
	end_game.connect(_end_game)
	

func _end_game() -> void:
	var final_score = storage.calculate_score()
	score.text = str(final_score)
	$Control.visible = true
	Global.toggle_pause.emit(true)
