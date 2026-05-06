class_name MessageScreen extends CanvasLayer

signal show_message(message: String)

@onready var label = $Control/Label


func _ready() -> void:
	$Control.visible = false
	self.process_mode = Node.PROCESS_MODE_DISABLED
	show_message.connect(_show_message)


func _show_message(message: String) -> void:
	label.text = message
	$Control.visible = true
	self.process_mode = Node.PROCESS_MODE_INHERIT
	Global.toggle_pause.emit.call_deferred(true)


func _input(input: InputEvent) -> void:
	if input.is_action_pressed("interact") or input.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		$Control.visible = false
		self.process_mode = Node.PROCESS_MODE_DISABLED
		Global.toggle_pause.emit.call_deferred(false)
