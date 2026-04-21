extends CanvasLayer

@export var inventory: Inventory

@onready var control = $Control


func _ready() -> void:
	control.visible = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		toggle_inventory()
	elif event.is_action_pressed("ui_cancel") and control.visible:
		toggle_inventory()


func toggle_inventory() -> void:
	control.visible = !control.visible
	if control.visible:
		$Control/InventoryGrid.refresh(inventory)
		Global.toggle_pause.emit(true)
	else:
		Global.toggle_pause.emit(false)
	#get_tree().paused = control.visible # this needs to pause only the game, not everything