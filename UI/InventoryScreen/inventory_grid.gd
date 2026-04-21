class_name InventoryGrid extends GridContainer

var slots: Array[InventorySlot]


func _ready() -> void:
	for child in get_children():
		if child is InventorySlot:
			slots.append(child)


func refresh(inventory: Inventory) -> void:
	for i in range(min(inventory.items.size(), slots.size())):
		if inventory.items[i] != null:
			slots[i].update_slot(inventory.items[i].item_data)


func remove_item(item_index: int) -> void:
	slots[item_index].clear()