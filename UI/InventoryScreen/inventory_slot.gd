class_name InventorySlot extends PanelContainer


func update_slot(item_data: ItemData, amount = 0) -> void:
	if item_data:
		$ItemImage.texture = item_data.large_icon
		$ItemImage.show()
		if item_data.stackable and amount > 0:
			$ItemCount.text = str(amount)
			$ItemCount.show()
		else:
			$ItemCount.hide()
	else:
		clear()


func clear() -> void:
	$ItemImage.texture = null
	$ItemImage.hide()
	$ItemCount.hide()