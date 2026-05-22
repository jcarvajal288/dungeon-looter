extends CharacterBody2D

const speed = 40
const starting_health = 2


func _ready() -> void:
	z_index =  Global.RenderOrder.PLAYER
	$StateMachine.init(self)
	$Health.set_health(starting_health)
	$Hurtbox.on_hit.connect($Health.take_damage)
