class_name Storage extends Resource

var storage_size = 5
var items = []


func _init() -> void:
	items.resize(storage_size)
	items.fill(null)


func add_item(item: InventoryItem, index: int) -> void:
	items[index] = item


func remove_item(index: int) -> InventoryItem:
	var item = items[index]
	items[index] = null
	return item


func has_item(index: int) -> bool:
	return index >= 0 and index < items.size() and items[index] != null