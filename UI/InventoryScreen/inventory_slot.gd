class_name InventorySlot extends PanelContainer


func update_slot(item_data: ItemData) -> void:
	print(item_data)
	if item_data:
		$ItemImage.texture = item_data.large_icon
		$ItemImage.show()
	else:
		$ItemImage.hide()