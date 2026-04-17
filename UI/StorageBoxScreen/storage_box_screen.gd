extends CanvasLayer

const INVENTORY_TOP_LEFT = Vector2(222, 37)
const INVENTORY_SELECTOR_SIDE = 33

@export var inventory: Inventory

@onready var control = $Control
@onready var inventory_selector: TextureRect = $Control/InventorySelector
@onready var storage_box_selector: TextureRect = $Control/StorageBoxSelector
@onready var selected_slot: Vector2i = Vector2i(0, 0)
@onready var inventory_grid = $Control/InventoryGrid

func _ready() -> void:
	inventory_selector.position = INVENTORY_TOP_LEFT
	storage_box_selector.visible = false
	control.visible = false
	Global.toggle_storage_box_screen.connect(toggle_screen)
	self.process_mode = Node.PROCESS_MODE_DISABLED


func toggle_screen() -> void:
	control.visible = !control.visible
	if control.visible:
		inventory_grid.refresh(inventory)
		self.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		self.process_mode = Node.PROCESS_MODE_DISABLED


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and control.visible:
		control.visible = false
	elif event.is_action_pressed("ui_left"):
		if selected_slot.x == 0:
			inventory_selector.visible = false
			storage_box_selector.visible = true
		else:
			selected_slot.x -= 1
	elif event.is_action_pressed("ui_right"): 
		if storage_box_selector.visible:
			inventory_selector.visible = true
			storage_box_selector.visible = false
		elif selected_slot.x == 0:
			selected_slot.x += 1
	elif event.is_action_pressed("ui_up") and selected_slot.y != 0:
		selected_slot.y -= 1
	elif event.is_action_pressed("ui_down") and selected_slot.y != 3:
		selected_slot.y += 1
	var new_x = INVENTORY_TOP_LEFT.x + selected_slot.x * INVENTORY_SELECTOR_SIDE
	var new_y = INVENTORY_TOP_LEFT.y + selected_slot.y * INVENTORY_SELECTOR_SIDE
	inventory_selector.position = Vector2(new_x, new_y)
		
