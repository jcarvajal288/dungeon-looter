class_name Inventory extends Resource

var inventory_size = 6
var items = []


func _init() -> void:
	items.resize(inventory_size)
	items.fill(null)


func add_item(item_data: ItemData) -> bool:
	for i in range(inventory_size):
		if items[i] == null:
			var item = InventoryItem.new()
			item.item_data = item_data
			item.amount = 0
			items[i] = item
			return true
	return false


func remove_item(index: int) -> InventoryItem:
	var item = items[index]
	items[index] = null
	return item