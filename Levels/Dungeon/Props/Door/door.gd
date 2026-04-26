class_name Door extends Prop

@export var door_id: String = ""

@onready var closed_frame = $Sprite2D.frame
@onready var open_frame = closed_frame + 8


func _ready() -> void:
	$InteractionArea.on_interaction.connect(on_interaction)	


func on_interaction() -> void:
	var is_closed = PersistentState.door_states[door_id]
	if is_closed:
		set_closed_state(false)


func set_closed_state(is_closed: bool) -> void:
	if is_closed:
		$Sprite2D.frame = closed_frame
	else:
		$Sprite2D.frame = open_frame
	$CollisionShape2D.disabled = not is_closed
	PersistentState.door_states[door_id] = is_closed
		
