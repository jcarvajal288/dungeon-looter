class_name Ranger extends CharacterBody2D

const toast_scene = preload("res://UI/ToastNotification/ToastNotification.tscn")

const speed = 80

var facing = "SouthEast"

@export var inventory: Inventory
@export var arrow_type: ItemData


func _ready() -> void:
	Global.player = self
	z_index =  Global.RenderOrder.PLAYER
	$StateMachine.init(self)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		InventoryScreen.toggle_inventory_screen.emit()
	elif event.is_action_pressed("interact"):
		check_for_interaction()
		get_viewport().set_input_as_handled()


func check_for_interaction() -> void:
	var nodes = get_interacting_nodes()
	for node in nodes:
		if node is Item:
			if inventory.add_item(node.item_data):
				node.queue_free()
			else:
				print("Inventory full")
		elif node is InteractionArea:
			node.on_interaction.emit()


func get_interacting_nodes() -> Array:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = $CollisionShape2D.shape
	query.transform = global_transform
	query.collide_with_areas = true 
	query.collide_with_bodies = false
	query.collision_mask = 1 << (Global.CollisionLayer.ITEM - 1)
	var results = space_state.intersect_shape(query)
	return results.map(func(result): return result.collider)


func has_ammo_left() -> bool:
	return inventory.contains_item_name("Arrow")


func spawn_toast(text_value: String, color: Color = Color.WHITE) -> void:
	var toast = toast_scene.instantiate()
	toast.text = text_value
	toast.modulate = color
	get_tree().current_scene.add_child(toast)
	toast.reset_size()
	var target_position = global_position + Vector2(0, -4.0)
	var half_size_offset = toast.size / 2
	toast.global_position = target_position - half_size_offset
	toast.start()


func get_equipped_ammo_type() -> ItemData:
	return arrow_type