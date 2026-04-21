extends CanvasLayer

const INVENTORY_TOP_LEFT = Vector2(222, 37)
const INVENTORY_SELECTOR_SIDE = 33

@export var inventory: Inventory
@export var storage: Storage

@onready var control = $Control
@onready var inventory_selector: TextureRect = $Control/InventorySelector
@onready var storage_box_selector: TextureRect = $Control/StorageBoxSelector
@onready var selected_slot: Vector2i = Vector2i(0, 0)
@onready var inventory_grid = $Control/InventoryGrid
@onready var storage_grid = $Control/StorageGrid
@onready var item_info = $Control/ItemInfo

enum States {
	SELECTING_INVENTORY,
	SELECTING_STORAGE,
	MOVING_TO_STORAGE,
	MOVING_TO_INVENTORY
}
@onready var state: States = States.SELECTING_INVENTORY

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
		Global.toggle_pause.emit(true)
	else:
		self.process_mode = Node.PROCESS_MODE_DISABLED
		Global.toggle_pause.emit(false)


func _input(event: InputEvent) -> void:
	if state == States.SELECTING_INVENTORY:
		handle_inventory_selection(event)
	elif state == States.MOVING_TO_STORAGE:
		handle_moving_to_storage(event)
	var new_x = INVENTORY_TOP_LEFT.x + selected_slot.x * INVENTORY_SELECTOR_SIDE
	var new_y = INVENTORY_TOP_LEFT.y + selected_slot.y * INVENTORY_SELECTOR_SIDE
	inventory_selector.position = Vector2(new_x, new_y)
	if state == States.SELECTING_INVENTORY:
		var slot_index = selected_slot.y * 2 + selected_slot.x
		item_info.update(inventory.items[slot_index])
	elif state == States.SELECTING_STORAGE:
		item_info.update(storage.items[2])



func handle_inventory_selection(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and control.visible:
		control.visible = false
	elif event.is_action_pressed("ui_left"):
		if selected_slot.x == 0:
			focus_storage_box(false)
			state = States.SELECTING_STORAGE
		else:
			selected_slot.x -= 1
	elif event.is_action_pressed("ui_right") and selected_slot.x == 0:
		selected_slot.x += 1
	elif event.is_action_pressed("ui_up") and selected_slot.y != 0:
		selected_slot.y -= 1
	elif event.is_action_pressed("ui_down") and selected_slot.y != 3:
		selected_slot.y += 1
	elif event.is_action_pressed("interact"):
		focus_storage_box(true)
		state = States.MOVING_TO_STORAGE


func handle_moving_to_storage(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		storage.add_item(get_selected_inventory_item(), 2)
		inventory_grid.refresh(inventory)
		storage_grid.refresh(storage)
		state = States.SELECTING_STORAGE


func get_selected_inventory_item() -> InventoryItem:
	var slot_index = selected_slot.y * 2 + selected_slot.x
	var item = inventory.remove_item(slot_index)
	inventory_grid.remove_item(slot_index)
	return item


func focus_inventory() -> void:
	inventory_selector.visible = true
	storage_box_selector.visible = false
	var slot_index = selected_slot.y * 2 + selected_slot.x
	item_info.update(inventory.items[slot_index])

func focus_storage_box(show_inventory_selection: bool) -> void:
	inventory_selector.visible = show_inventory_selection
	storage_box_selector.visible = true
