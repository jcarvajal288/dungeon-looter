extends CharacterBody2D

const speed = 40
const starting_health = 2


func _ready() -> void:
	z_index =  Global.RenderOrder.PLAYER
	$StateMachine.init(self)
	$Health.set_health(starting_health)
	$Hurtbox.on_hit.connect(_on_damage)
	$Health.on_death.connect(_on_death)


func _on_damage(damage: float) -> void:
	$Health.take_damage(damage)
	if $Health.current_health > 0:
		$StateMachine.signal_state_change.emit($StateMachine/Damage)


func _on_death() -> void:
	$StateMachine.signal_state_change.emit($StateMachine/Die)


func _process(_delta: float) -> void:
	if $VisionCone.can_see(Global.player):
		print("player spotted")