extends CanvasLayer

@export var inventory: Inventory

const INVENTORY_TOP_LEFT = Vector2(222, 37)
const INVENTORY_SELECTOR_SIDE = 33

signal toggle_inventory_screen

@onready var control = $Control
@onready var item_info = $Control/ItemInfo
@onready var selected_inventory_slot: Vector2i = Vector2i(0, 0)
@onready var inventory_selector: TextureRect = $Control/InventorySelector


func _ready() -> void:
	control.visible = false
	toggle_inventory_screen.connect(toggle_inventory)
	self.process_mode = Node.PROCESS_MODE_DISABLED


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and control.visible:
		toggle_inventory()
	handle_inventory_selection(event)
	var new_x = INVENTORY_TOP_LEFT.x + selected_inventory_slot.x * INVENTORY_SELECTOR_SIDE
	var new_y = INVENTORY_TOP_LEFT.y + selected_inventory_slot.y * INVENTORY_SELECTOR_SIDE
	inventory_selector.position = Vector2(new_x, new_y)
	var slot_index = selected_inventory_slot.y * 2 + selected_inventory_slot.x
	item_info.update(inventory.items[slot_index])


func toggle_inventory() -> void:
	control.visible = !control.visible
	if control.visible:
		$Control/InventoryGrid.refresh(inventory)
		Global.toggle_pause.emit(true)
		self.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		Global.toggle_pause.emit(false)


func handle_inventory_selection(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		if selected_inventory_slot.x > 0:
			selected_inventory_slot.x -= 1
	elif event.is_action_pressed("ui_right") and selected_inventory_slot.x == 0:
		selected_inventory_slot.x += 1
	elif event.is_action_pressed("ui_up") and selected_inventory_slot.y != 0:
		selected_inventory_slot.y -= 1
	elif event.is_action_pressed("ui_down") and selected_inventory_slot.y != 3:
		selected_inventory_slot.y += 1
	elif event.is_action_pressed("interact"):
		pass # to fill in later
