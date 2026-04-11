class_name Item extends Area2D

var item_code = 0

func _ready() -> void:
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_layer_value(Global.CollisionLayer.ITEM, true)
	set_collision_mask_value(Global.CollisionLayer.ITEM, true)