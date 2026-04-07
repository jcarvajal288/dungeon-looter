extends Room


func get_entry_point(entry_id: String) -> Vector2:
	if entry_id == "WesternExit":
		return $WesternExit/PlayerEntryPoint.global_position
	else:
		printerr("Invalid entry id in TestRoomEast: ", entry_id)
		return Vector2.ZERO


