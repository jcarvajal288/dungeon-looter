class_name GemPlinth extends Prop

@export var correct_item: ItemData
@export var slotable_items: Array[ItemData]


func _ready() -> void:
	super()
	$ItemSlotArea.on_interaction.connect(on_interaction)	
	$ItemSlotArea.set_slotable_items(slotable_items)


func on_interaction() -> void:
	var item_in_slot = $ItemSlotArea.item_in_slot
	if item_in_slot != null:
		NotificationScreen.show_message.emit("The %s has been set in the plinth." % item_in_slot.name)
	else:
		NotificationScreen.show_message.emit("You see a round impression in the plinth.")
