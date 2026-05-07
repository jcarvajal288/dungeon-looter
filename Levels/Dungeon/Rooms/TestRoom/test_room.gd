extends Room

func _ready() -> void:
	super()
	$EasternExit/Door.set_closed_state(PersistentState.door_states["TEST_ROOM_EASTERN_EXIT"])
	$GemPlinthRed.solved.connect(check_gem_puzzle)
	$GemPlinthGreen.solved.connect(check_gem_puzzle)
	$GemPlinthBlue.solved.connect(check_gem_puzzle)


func get_entry_point(entry_id: String) -> Vector2:
	if entry_id == "EasternExit":
		return $EasternExit/PlayerEntryPoint.global_position
	elif entry_id == "ExitToOutside":
		return $ExitToOutside/PlayerEntryPoint.global_position
	elif entry_id == "WesternExit":
		return $WesternExit/PlayerEntryPoint.global_position
	else:
		printerr("Invalid entry id in TestRoom: ", entry_id)
		return Vector2.ZERO


func check_gem_puzzle() -> void:
	var red_solved = $GemPlinthRed.correct_gem_in_slot()
	var green_solved = $GemPlinthGreen.correct_gem_in_slot()
	var blue_solved = $GemPlinthBlue.correct_gem_in_slot()
	if red_solved and green_solved and blue_solved:
		$WesternExit/PuzzleDoor.set_closed_state(false)
		$GemPlinthRed.is_locked = true
		$GemPlinthGreen.is_locked = true
		$GemPlinthBlue.is_locked = true