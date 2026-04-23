class_name StorageGrid extends GridContainer

var slots: Array[StorageSlot]

@onready var top_slot_index = 0


func _ready() -> void:
	for child in get_children():
		if child is StorageSlot:
			slots.append(child)


func refresh(storage: Inventory) -> void:
	for i in range(min(storage.items.size(), slots.size())):
		if storage.items[i] != null:
			slots[i].update_slot(storage.items[i].item_data)


func remove_item(item_index: int) -> void:
	slots[item_index].clear()


func selected_storage_index() -> int:
	return top_slot_index + 2