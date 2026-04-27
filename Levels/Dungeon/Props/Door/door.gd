class_name Door extends Prop

@export var door_id: String = ""
@export var opened_by: ItemData = null

@onready var closed_frame = $Sprite2D.frame
@onready var open_frame = closed_frame + 8


func _ready() -> void:
	$InteractionArea.on_interaction.connect(on_interaction)	


func on_interaction() -> void:
	var is_closed = PersistentState.door_states[door_id]
	if is_closed:
		var is_locked = true if door_id != null else false
		if not is_locked:
			set_closed_state(false)
		var has_key = Global.player.inventory.contains(opened_by)
		if has_key:
			NotificationScreen.show_message.emit("Unlocked the door with %s" % opened_by.name)
			set_closed_state(false)
		else:
			NotificationScreen.show_message.emit("The door is locked")


func set_closed_state(is_closed: bool) -> void:
	if is_closed:
		$Sprite2D.frame = closed_frame
	else:
		$Sprite2D.frame = open_frame
	$CollisionShape2D.disabled = not is_closed
	PersistentState.door_states[door_id] = is_closed
		
