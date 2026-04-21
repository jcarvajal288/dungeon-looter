class_name StorageSlot extends HBoxContainer


func update_slot(item_data: ItemData) -> void:
	if item_data:
		$ItemImage.texture = item_data.large_icon
		$ItemImage.show()
	else:
		$ItemImage.hide()
