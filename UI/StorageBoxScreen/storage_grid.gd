class_name StorageGrid extends GridContainer

var slots: Array[StorageSlot]

@onready var top_slot_index = 0


func _ready() -> void:
	for child in get_children():
		if child is StorageSlot:
			slots.append(child)


func refresh(storage: Inventory) -> void:
	var slot_index_range = range(slots.size()) \
		.map(func(i): return top_slot_index + i) \
		.map(func(i):
			if i >= slots.size():
				return i - slots.size()
			elif i < 0:
				return slots.size() - i
			else:
				return i)
	for i in range(slots.size()):
		if storage.items[slot_index_range[i]] == null:
			slots[i].clear()
		else:
			slots[i].update_slot(storage.items[slot_index_range[i]].item_data)


func remove_item(item_index: int) -> void:
	slots[item_index].clear()


func selected_storage_index() -> int:
	return top_slot_index + 2


func change_storage_selection(index_change: int) -> void:
	top_slot_index += index_change
	if top_slot_index < 0:
		top_slot_index = slots.size() - 1
	elif top_slot_index >= slots.size():
		top_slot_index = 0
