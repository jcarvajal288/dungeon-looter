extends Room


func get_entry_point(entry_id: String) -> Vector2:
	if entry_id == "TransitionToDungeon":
		return $TransitionToDungeon/PlayerEntryPoint.global_position
	else:
		printerr("Invalid entry id in TestRoom: ", entry_id)
		return Vector2.ZERO

