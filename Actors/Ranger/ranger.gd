class_name Ranger extends CharacterBody2D

const speed = 80

var facing = "SouthEast"

@export var inventory: Inventory

func _ready() -> void:
	Global.player = self
	z_index =  Global.RenderOrder.PLAYER


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		InventoryScreen.toggle_inventory_screen.emit()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		check_for_item()


func _physics_process(_delta: float) -> void:
	var movement_vector = get_movement_vector()
	move(movement_vector)
	animate(movement_vector)


func get_movement_vector() -> Vector2:
	var mv = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var snapped_vector = Vector2(
		snapped(mv.x, 0.5), 
		snapped(mv.y, 0.5)
	).normalized()
	return snapped_vector


func move(movement_vector: Vector2) -> void:
	velocity = movement_vector * speed
	move_and_slide()


func animate(movement_vector: Vector2) -> void:
	if movement_vector == Vector2.ZERO:
		$AnimationPlayer.play("idle" + facing)
	else:
		facing = determine_facing(movement_vector)
		$AnimationPlayer.play("walk" + facing)


func determine_facing(direction: Vector2) -> String:
	if direction.x >= 0:
		if direction.y >= 0:
			return "SouthEast"
		else:
			return "NorthEast"
	elif direction.x < 0:
		if direction.y >= 0:
			return "SouthWest"
		else:
			return "NorthWest"
	else:
		return facing


func check_for_item() -> void:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = $CollisionShape2D.shape
	query.transform = global_transform
	query.collide_with_areas = true 
	query.collide_with_bodies = false
	query.collision_mask = 1 << (Global.CollisionLayer.ITEM - 1)

	var results = space_state.intersect_shape(query)
	for result in results:
		var node = result.collider
		if node is Item:
			if inventory.add_item(node.item_data):
				node.queue_free()
			else:
				print("Inventory full")
		elif node.name == "InteractionArea":
			if node.get_parent() is WagonStorageBox:
				StorageBoxScreen.toggle_storage_box_screen.emit()
			elif node.get_parent() is Horse:
				EndScreen.end_game.emit()
