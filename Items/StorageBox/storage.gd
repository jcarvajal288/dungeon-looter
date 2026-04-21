class_name Storage extends Resource

var storage_size = 5
var items = []


func _init() -> void:
	items.resize(storage_size)
	items.fill(null)


func add_item(item: InventoryItem, index: int) -> void:
	items[index] = item