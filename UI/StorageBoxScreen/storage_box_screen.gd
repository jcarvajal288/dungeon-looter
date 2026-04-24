extends CanvasLayer

const INVENTORY_TOP_LEFT = Vector2(222, 37)
const INVENTORY_SELECTOR_SIDE = 33

@export var inventory: Inventory
@export var storage: Inventory

@onready var control = $Control
@onready var inventory_selector: TextureRect = $Control/InventorySelector
@onready var storage_box_selector: TextureRect = $Control/StorageBoxSelector
@onready var selected_inventory_slot: Vector2i = Vector2i(0, 0)
@onready var inventory_grid = $Control/InventoryGrid
@onready var storage_grid = $Control/StorageGrid
@onready var item_info = $Control/ItemInfo

enum MenuState {
	SELECTING_INVENTORY,
	SELECTING_STORAGE,
	MOVING_TO_STORAGE,
	MOVING_TO_INVENTORY
}
@onready var current_state: MenuState = MenuState.SELECTING_INVENTORY

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
	if event.is_action_pressed("ui_cancel") and control.visible:
		toggle_screen()
		return
	match current_state:
		MenuState.SELECTING_INVENTORY:
			handle_inventory_selection(event)
			var slot_index = selected_inventory_slot.y * 2 + selected_inventory_slot.x
			item_info.update(inventory.items[slot_index])
		MenuState.SELECTING_STORAGE:
			handle_storage_selection(event)
			item_info.update(storage.items[storage_grid.selected_storage_index()])
		MenuState.MOVING_TO_INVENTORY:
			handle_inventory_selection(event)
		MenuState.MOVING_TO_STORAGE:
			handle_moving_to_storage(event)
	var new_x = INVENTORY_TOP_LEFT.x + selected_inventory_slot.x * INVENTORY_SELECTOR_SIDE
	var new_y = INVENTORY_TOP_LEFT.y + selected_inventory_slot.y * INVENTORY_SELECTOR_SIDE
	inventory_selector.position = Vector2(new_x, new_y)


func change_state(new_state: MenuState) -> void:
	current_state = new_state
	match current_state:
		MenuState.SELECTING_INVENTORY:
			focus_inventory()
		MenuState.SELECTING_STORAGE:
			focus_storage_box()
		MenuState.MOVING_TO_INVENTORY:
			focus_inventory()
		MenuState.MOVING_TO_STORAGE:
			focus_both()


func handle_inventory_selection(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		if selected_inventory_slot.x == 0:
			change_state(MenuState.SELECTING_STORAGE)
		else:
			selected_inventory_slot.x -= 1
	elif event.is_action_pressed("ui_right") and selected_inventory_slot.x == 0:
		selected_inventory_slot.x += 1
	elif event.is_action_pressed("ui_up") and selected_inventory_slot.y != 0:
		selected_inventory_slot.y -= 1
	elif event.is_action_pressed("ui_down") and selected_inventory_slot.y != 3:
		selected_inventory_slot.y += 1
	elif event.is_action_pressed("interact"):
		if current_state == MenuState.SELECTING_INVENTORY:
			change_state(MenuState.MOVING_TO_STORAGE)
		elif current_state == MenuState.MOVING_TO_INVENTORY:
			var inventory_slot_index = selected_inventory_slot.y * 2 + selected_inventory_slot.x
			var item = get_selected_storage_item()
			if item:
				inventory.add_inventory_item(item, inventory_slot_index)
				inventory_grid.refresh(inventory)
				storage_grid.refresh(storage)
				change_state(MenuState.SELECTING_INVENTORY)


func handle_storage_selection(event: InputEvent) -> void:
	move_storage_selector(event)
	if event.is_action_pressed("interact"):
		if storage.has_item(storage_grid.selected_storage_index()):
			change_state(MenuState.MOVING_TO_INVENTORY)


func handle_moving_to_storage(event: InputEvent) -> void:
	move_storage_selector(event)	
	if event.is_action_pressed("interact"):
		storage.add_inventory_item(get_selected_inventory_item(), storage_grid.selected_storage_index())
		inventory_grid.refresh(inventory)
		storage_grid.refresh(storage)
		change_state(MenuState.SELECTING_STORAGE)


func move_storage_selector(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		change_state(MenuState.SELECTING_INVENTORY)
	elif event.is_action_pressed("ui_up"):
		storage_grid.change_storage_selection(-1)
		storage_grid.refresh(storage)
	elif event.is_action_pressed("ui_down"):
		storage_grid.change_storage_selection(1)
		storage_grid.refresh(storage)

func get_selected_inventory_item() -> InventoryItem:
	var slot_index = selected_inventory_slot.y * 2 + selected_inventory_slot.x
	var item = inventory.remove_item(slot_index)
	inventory_grid.remove_item(slot_index)
	return item


func get_selected_storage_item() -> InventoryItem:
	var item = storage.remove_item(storage_grid.selected_storage_index())
	if item:
		storage_grid.remove_item(storage_grid.selected_storage_index())
	return item


func focus_inventory() -> void:
	inventory_selector.visible = true
	storage_box_selector.visible = false
	var slot_index = selected_inventory_slot.y * 2 + selected_inventory_slot.x
	item_info.update(inventory.items[slot_index])


func focus_storage_box() -> void:
	inventory_selector.visible = false
	storage_box_selector.visible = true


func focus_both() -> void:
	inventory_selector.visible = true
	storage_box_selector.visible = true
