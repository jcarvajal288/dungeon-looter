class_name Prop extends StaticBody2D


func _ready() -> void:
	z_index = Global.RenderOrder.PLAYER
	$InteractionArea.on_interaction.connect(on_interaction)	


func on_interaction() -> void:
	pass

