class_name StorageGrid extends GridContainer

var slots: Array[StorageSlot]


func _ready() -> void:
	for child in get_children():
		if child is StorageSlot:
			slots.append(child)


func refresh(storage: Storage) -> void:
	for i in range(min(storage.items.size(), slots.size())):
		if storage.items[i] != null:
			slots[i].update_slot(storage.items[i].item_data)
