class_name InventoryGrid extends GridContainer

var slots: Array[InventorySlot]


func _ready() -> void:
	for child in get_children():
		if child is InventorySlot:
			slots.append(child)


func refresh(inventory: Inventory) -> void:
	for i in range(min(inventory.items.size(), slots.size())):
		var inventory_item = inventory.items[i]
		if inventory_item != null:
			slots[i].update_slot(inventory_item.item_data, inventory_item.amount)
		else:
			slots[i].clear()


func remove_item(item_index: int) -> void:
	slots[item_index].clear()