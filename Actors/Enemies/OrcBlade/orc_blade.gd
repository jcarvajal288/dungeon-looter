extends CharacterBody2D

const speed = 40


func _ready() -> void:
	z_index =  Global.RenderOrder.PLAYER
	$StateMachine.init(self)