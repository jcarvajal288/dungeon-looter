class_name Inventory extends Resource

var size = 8
var items = []


func _init() -> void:
	items.resize(size)
	items.fill(null)


func add_item(item_data: ItemData) -> bool:
	for i in range(size):
		if items[i] == null:
			var item = InventoryItem.new()
			item.item_data = item_data
			item.amount = 0
			items[i] = item
			return true
	return false


func add_inventory_item(inventory_item: InventoryItem, index: int) -> bool: 
	if items[index] == null:
		items[index] = inventory_item
		return true
	else:
		return false


func remove_item(index: int) -> InventoryItem:
	var item = items[index]
	items[index] = null
	return item


func has_item(index: int) -> bool:
	return index >= 0 and index < items.size() and items[index] != null