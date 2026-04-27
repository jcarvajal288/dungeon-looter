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


func has_item_at_index(index: int) -> bool:
	return index >= 0 and index < items.size() and items[index] != null


func contains(item_data: ItemData) -> bool:
	return items.filter(func(i): 
		return i != null and i.item_data.name == item_data.name).size() > 0


func calculate_score() -> int:
	var scores = items \
		.filter(func(item): return item != null) \
		.map(func(item): return [item.item_data.value, item.item_data.multiplier]) \
	 	.reduce(func(totals, next): return [totals[0] + next[0], totals[1] * next[1]])
	if scores:
		return int(scores[0] * scores[1])
	else:
		return 0
