class_name FlyingArrow extends Area2D

const EAST_NORTH_EAST = -PI / 8
const NORTH_NORTH_EAST = -3 * PI / 8
const NORTH_NORTH_WEST = -5 * PI / 8
const WEST_NORTH_WEST = -7 * PI / 8
const EAST_SOUTH_EAST = PI / 8
const SOUTH_SOUTH_EAST = 3 * PI / 8
const SOUTH_SOUTH_WEST = 5 * PI / 8
const WEST_SOUTH_WEST = 7 * PI / 8

var speed = 400
var direction = Vector2.ZERO
@onready var velocity = speed * direction


func _ready() -> void:
	z_index = Global.RenderOrder.PLAYER
	set_direction_frame()
	body_entered.connect(collide)
	area_entered.connect(queue_free)


func _physics_process(delta: float) -> void:
	global_position += velocity * delta	


func set_direction_frame() -> void:
	var angle = velocity.angle()
	if EAST_NORTH_EAST < angle and angle <= EAST_SOUTH_EAST:
		$Sprite2D.frame = 5 # East
	elif EAST_SOUTH_EAST < angle and angle <= SOUTH_SOUTH_EAST:
		$Sprite2D.frame = 8 # Southeast
	elif SOUTH_SOUTH_EAST < angle and angle <= SOUTH_SOUTH_WEST:
		$Sprite2D.frame = 7 # South
	elif SOUTH_SOUTH_WEST < angle and angle <= WEST_SOUTH_WEST:
		$Sprite2D.frame = 6 # Southwest
	elif NORTH_NORTH_EAST < angle and angle <= EAST_NORTH_EAST:
		$Sprite2D.frame = 2 # Northeast
	elif NORTH_NORTH_WEST < angle and angle <= NORTH_NORTH_EAST:
		$Sprite2D.frame = 1 # North
	elif WEST_NORTH_WEST < angle and angle <= NORTH_NORTH_WEST:
		$Sprite2D.frame = 0 # Northwest
	else:
		$Sprite2D.frame = 3 # West


func collide(_node: Node2D) -> void:
	queue_free()