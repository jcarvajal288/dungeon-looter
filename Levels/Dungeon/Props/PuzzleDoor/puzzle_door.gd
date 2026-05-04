class_name PuzzleDoor extends Prop

@export var door_id: String = ""

@onready var closed_frame = $Sprite2D.frame
@onready var open_frame = closed_frame + 8


func _ready() -> void:
	super()
	Global.unlock_door.connect(unlock_door)


func on_interaction() -> void:
	var is_closed = PersistentState.door_states[door_id]
	if is_closed:
		NotificationScreen.show_message.emit("The door is locked by some contraption")


func set_closed_state(is_closed: bool) -> void:
	if is_closed:
		$Sprite2D.frame = closed_frame
	else:
		$Sprite2D.frame = open_frame
	$CollisionShape2D.disabled = not is_closed
	PersistentState.door_states[door_id] = is_closed
		

func unlock_door(did: String) -> void:
	if door_id == did:
		set_closed_state(false)
