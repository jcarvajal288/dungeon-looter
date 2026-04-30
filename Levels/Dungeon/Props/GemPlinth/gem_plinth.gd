class_name GemPlinth extends Prop

@export var key_item: ItemData


func _ready() -> void:
	$InteractionArea.on_interaction.connect(on_interaction)	
	$ItemSlot.key_item = key_item


func on_interaction() -> void:
	if $ItemSlot.is_solved():
		NotificationScreen.show_message.emit("The %s has been set in the plinth." % key_item.name)
	else:
		NotificationScreen.show_message.emit("You see a round impression in the plinth.")