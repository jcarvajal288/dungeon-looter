class_name Door extends Prop

@onready var is_closed = true
@onready var closed_frame = $Sprite2D.frame
@onready var open_frame = closed_frame + 8


func _ready() -> void:
	$InteractionArea.on_interaction.connect(on_interaction)	


func on_interaction() -> void:
	if is_closed:
		$Sprite2D.frame = open_frame
		$CollisionShape2D.disabled = true
		