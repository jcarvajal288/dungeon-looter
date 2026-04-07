extends Node

var current_room: Room


func _ready() -> void:
	Global.transition_room.connect(_transition_room)


func _transition_room(next_room_path: String, entry_id: String) -> void:
	Global.player.get_node("CollisionShape2D").set_deferred("disabled", true)
	current_room.queue_free()
	var room = load(next_room_path).instantiate()
	current_room = room
	call_deferred("add_child", room)

	var target_position = room.get_entry_point(entry_id)
	var is_obstructed = true
	while is_obstructed:
		is_obstructed = check_for_collisions_at(target_position)
		if is_obstructed:
			await get_tree().physics_frame
		else:
			Global.player.global_position = room.get_entry_point(entry_id)


func check_for_collisions_at(pos: Vector2) -> bool:
	var space_state = Global.player.get_world_2d().direct_space_state
	var shape_rid = Global.player.get_node("CollisionShape2D").shape.get_rid()
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape_rid = shape_rid
	query.transform = Transform2D(0, pos)
	query.collision_mask = Global.player.collision_mask
	return space_state.intersect_shape(query).size() > 0


func set_room(room: Room) -> void:
	current_room = room
	add_child(room)
