extends VBoxContainer


func update(inventory_item: InventoryItem) -> void:
	if inventory_item:
		var item_data = inventory_item.item_data
		$Name.text = item_data.name
		$Description.text = item_data.description
	else:
		$Name.text = ""
		$Description.text = ""