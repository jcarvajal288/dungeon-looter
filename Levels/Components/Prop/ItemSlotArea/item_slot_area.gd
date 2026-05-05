class_name ItemSlotArea extends InteractionArea

@export var slotable_item_names: Array[String]

var item_in_slot = null

signal item_put_in_slot


func _ready() -> void:
	$Sprite2D.visible = false


func set_slotable_items(slotable_items: Array[ItemData]) -> void:
	slotable_item_names.assign(slotable_items.map(func(i): return i.name))


func interact_with_item(item: ItemData) -> bool:
	if item.name in slotable_item_names:
		item_in_slot = item
		$Sprite2D.texture = item.small_icon
		$Sprite2D.visible = true
		item_put_in_slot.emit()
		return true
	else:
		return false
