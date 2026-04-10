extends Node

class InventoryItem:
	var item_id: int
	var amount: int

var inventory_size = 6
var slots = []


func _ready() -> void:
	slots.resize(inventory_size)
	slots.fill(null)


func add_item(item_code: Items.ItemCode) -> bool:
	for i in range(inventory_size):
		if slots[i] == null:
			var item = InventoryItem.new()
			item.item_id = item_code
			item.amount = 0
			slots[i] = item
			return true
	return false
