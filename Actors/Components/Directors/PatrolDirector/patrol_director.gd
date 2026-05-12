extends Director

@export var is_loop: bool = true
var patrol_points: Array[Marker2D]
var destination_index = 0
var is_reverse: bool = false


func _ready() -> void:
	for child in get_children():
		if child is Marker2D:
			patrol_points.append(child)


func _process(_delta: float) -> void:
	reset()
	var destination = patrol_points[destination_index]
	var distance_to_destination = subject.global_position.distance_to(destination.global_position)
	if distance_to_destination <= 2.0:
		if is_reverse:
			destination_index -= 1
			if destination_index < 0:
				if is_loop:
					destination_index = patrol_points.size() - 1
				else:
					destination_index = 1
					is_reverse = false
		else:
			destination_index += 1
			if destination_index >= patrol_points.size():
				if is_loop:
					destination_index = 0
				else:
					destination_index = patrol_points.size() - 1
					is_reverse = true
		destination = patrol_points[destination_index]
	movement_vector = subject.global_position.direction_to(destination.global_position)
