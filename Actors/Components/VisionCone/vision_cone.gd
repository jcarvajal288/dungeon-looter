class_name VisionCone extends Area2D

@export var length: float
@export var width: float
@export var director: Director

@onready var nodes_in_fov: Dictionary[Node2D, RayCast2D]


func _ready() -> void:
	$CollisionPolygon2D.polygon[1] = Vector2(width / 2, length)
	$CollisionPolygon2D.polygon[2] = Vector2(-width / 2, length)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	var ray = RayCast2D.new()
	ray.collision_mask = collision_mask 
	ray.collision_mask |= Global.CollisionLayer.WALL
	nodes_in_fov[body] = ray
	add_child(ray)


func _on_body_exited(body: Node2D) -> void:
	nodes_in_fov[body].queue_free()
	nodes_in_fov.erase(body)


func _process(_delta: float) -> void:
	rotation = director.movement_vector.angle() - PI / 2
	for node in nodes_in_fov:
		var ray = nodes_in_fov[node]
		ray.target_position = (node.global_position - global_position).rotated(-rotation)


func can_see(target: Node2D) -> bool:
	for node in nodes_in_fov:
		if nodes_in_fov[node].get_collider() == target:
			return true
	return false
