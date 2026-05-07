class_name GemPlinth extends Prop

@export var correct_item: ItemData
@export var slotable_items: Array[ItemData]

@onready var is_solved = false
@onready var is_locked = false

signal solved


func _ready() -> void:
	super()
	$ItemSlotArea.on_interaction.connect(on_interaction)	
	$ItemSlotArea.item_put_in_slot.connect(on_item_put_in_slot)	
	$ItemSlotArea.set_slotable_items(slotable_items)


func on_interaction() -> void:
	var item_in_slot = $ItemSlotArea.item_in_slot
	if item_in_slot != null:
		if is_locked:
			NotificationScreen.show_message.emit("The %s is locked into the plinth." % item_in_slot.name)
		else:
			NotificationScreen.show_message.emit("You take the %s." % item_in_slot.name)
			$ItemSlotArea.move_item_to_player_inventory()
	else:
		NotificationScreen.show_message.emit("You see a round impression in the plinth.")


func on_item_put_in_slot(item_name: String) -> void:
	if item_name == correct_item.name:
		is_solved = true
		solved.emit()


func correct_gem_in_slot() -> bool:
	return $ItemSlotArea.item_in_slot != null \
	and correct_item.name == $ItemSlotArea.item_in_slot.name