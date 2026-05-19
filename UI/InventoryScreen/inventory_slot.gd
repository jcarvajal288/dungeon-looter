class_name InventorySlot extends PanelContainer


func update_slot(item_data: ItemData) -> void:
	if item_data:
		$ItemImage.texture = item_data.large_icon
		$ItemImage.show()
		$ItemCount.show()
	else:
		clear()


func clear() -> void:
	$ItemImage.texture = null
	$ItemImage.hide()
	$ItemCount.hide()