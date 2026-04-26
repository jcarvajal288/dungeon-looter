extends CanvasLayer

signal end_game

@onready var score = $Control/VBoxContainer/Score

func _ready() -> void:
	$Control.visible = false
	end_game.connect(_end_game)
	

func _end_game() -> void:
	score.text = str(1000000)
	$Control.visible = true
	Global.toggle_pause.emit(true)
