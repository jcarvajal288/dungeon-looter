extends Director

var patrol_points: Array[Marker2D]
var destination_index = 0


func _ready() -> void:
	for child in get_children():
		if child is Marker2D:
			patrol_points.append(child)


func _process(_delta: float) -> void:
	reset()
	var destination = patrol_points[destination_index]
	var distance_to_destination = subject.global_position.distance_to(destination.global_position)
	if distance_to_destination <= 2.0:
		destination_index += 1
		if destination_index >= patrol_points.size():
			destination_index = 0
		destination = patrol_points[destination_index]
	movement_vector = subject.global_position.direction_to(destination.global_position)
