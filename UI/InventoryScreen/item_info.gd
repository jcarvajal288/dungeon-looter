extends HBoxContainer


func update(inventory_item: InventoryItem) -> void:
	if inventory_item:
		var item_data = inventory_item.item_data
		$LeftSide/Name.text = item_data.name
		$LeftSide/Description.text = item_data.description
		$RightSide/Value.text = str(item_data.value)
		$RightSide/Multiplier.text = str(item_data.multiplier)
	else:
		$LeftSide/Name.text = ""
		$LeftSide/Description.text = ""
		$RightSide/Value.text = ""
		$RightSide/Multiplier.text = ""