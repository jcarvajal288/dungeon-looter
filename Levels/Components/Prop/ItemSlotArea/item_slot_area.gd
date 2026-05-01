class_name ItemSlotArea extends InteractionArea

@export var key_item: ItemData

signal key_item_slotted_in


func _ready() -> void:
	$Sprite2D.visible = false


func interact_with_item(item: ItemData) -> bool:
	if item.name == key_item.name:
		$Sprite2D.texture = key_item.small_icon
		$Sprite2D.visible = true
		key_item_slotted_in.emit()
		return true
	else:
		return false


func is_solved() -> bool:
	return $Sprite2D.visible
