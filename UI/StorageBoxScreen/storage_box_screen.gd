extends CanvasLayer

const INVENTORY_TOP_LEFT = Vector2(222, 37)

@onready var control = $Control
@onready var in_inventory_screen = true
@onready var inventory_selector: TextureRect = $Control/InventorySelector
@onready var storage_box_selector: TextureRect = $Control/StorageBoxSelector

func _ready() -> void:
	inventory_selector.position = INVENTORY_TOP_LEFT
	storage_box_selector.visible = false
	control.visible = false
	Global.toggle_storage_box_screen.connect(toggle_screen)


func toggle_screen() -> void:
	control.visible = !control.visible
