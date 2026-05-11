extends AnimationPlayer

var facing = "SouthEast"


const EAST_NORTH_EAST = -PI / 8
const NORTH_NORTH_EAST = -3 * PI / 8
const NORTH_NORTH_WEST = -5 * PI / 8
const WEST_NORTH_WEST = -7 * PI / 8
const EAST_SOUTH_EAST = PI / 8
const SOUTH_SOUTH_EAST = 3 * PI / 8
const SOUTH_SOUTH_WEST = 5 * PI / 8
const WEST_SOUTH_WEST = 7 * PI / 8


func set_facing(direction: Vector2):
	if direction == Vector2.ZERO:
		return
	if direction.x >= 0:
		if direction.y >= 0:
			facing = "SouthEast"
		else:
			facing = "NorthEast"
	elif direction.x < 0:
		if direction.y >= 0:
			facing = "SouthWest"
		else:
			facing = "NorthWest"


func set_facing_4_way(direction: Vector2):
	facing = convert_to_4_way(direction)


func play_with_facing(anim_name: String):
	self.play(anim_name + facing)


func play_four_way(anim_name: String, direction: Vector2):
	var dirString = convert_to_4_way(direction)
	self.play(anim_name + dirString)


func play_eight_way(anim_name: String, direction: Vector2):
	var dirString = convert_to_8_way(direction)
	self.play(anim_name + dirString)


func convert_to_4_way(direction: Vector2) -> String:
	var angle = direction.angle()
	if NORTH_NORTH_WEST < angle and angle <= EAST_NORTH_EAST:
		return "NorthEast"
	elif EAST_NORTH_EAST < angle and angle <= SOUTH_SOUTH_EAST:
		return "SouthEast"
	elif SOUTH_SOUTH_EAST < angle and angle <= WEST_SOUTH_WEST:
		return "SouthWest"
	else:
		return "NorthWest"


func convert_to_8_way(direction: Vector2) -> String:
	var angle = direction.angle()
	if EAST_NORTH_EAST < angle and angle <= EAST_SOUTH_EAST:
		return "East" 
	elif EAST_SOUTH_EAST < angle and angle <= SOUTH_SOUTH_EAST:
		return "SouthEast" 
	elif SOUTH_SOUTH_EAST < angle and angle <= SOUTH_SOUTH_WEST:
		return "South" 
	elif SOUTH_SOUTH_WEST < angle and angle <= WEST_SOUTH_WEST:
		return "SouthWest" 
	elif NORTH_NORTH_EAST < angle and angle <= EAST_NORTH_EAST:
		return "NorthEast" 
	elif NORTH_NORTH_WEST < angle and angle <= NORTH_NORTH_EAST:
		return "North" 
	elif WEST_NORTH_WEST < angle and angle <= NORTH_NORTH_WEST:
		return "NorthWest" 
	else:
		return "West" 