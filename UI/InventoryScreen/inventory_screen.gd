extends CanvasLayer

@onready var inventory = $Control


func _ready() -> void:
	inventory.visible = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		toggle_inventory()
	elif event.is_action_pressed("ui_cancel") and inventory.visible:
		toggle_inventory()


func toggle_inventory() -> void:
	inventory.visible = !inventory.visible
	#get_tree().paused = inventory.visible # this needs to pause only the game, not everything