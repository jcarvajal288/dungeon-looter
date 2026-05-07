class_name ItemSlotArea extends InteractionArea

@export var slotable_item_names: Array[String]

var item_in_slot: ItemData = null

signal item_put_in_slot(item_name: String)


func _ready() -> void:
	$Sprite2D.visible = false


func set_slotable_items(slotable_items: Array[ItemData]) -> void:
	slotable_item_names.assign(slotable_items.map(func(i): return i.name))


func interact_with_item(item: ItemData) -> bool:
	if item_in_slot != null:
		NotificationScreen.show_message.emit("The slot is not empty")	
		return false
	elif item.name in slotable_item_names:
		item_in_slot = item
		$Sprite2D.texture = item.small_icon
		$Sprite2D.visible = true
		item_put_in_slot.emit(item.name)
		return true
	else:
		NotificationScreen.show_message.emit("This item does not fit in this slot")	
		return false


func move_item_to_player_inventory():
	if item_in_slot == null:
		push_error("Attempting to take item from empty item slot")
		return
	Global.player.inventory.add_item(item_in_slot)
	item_in_slot = null
	$Sprite2D.visible = false