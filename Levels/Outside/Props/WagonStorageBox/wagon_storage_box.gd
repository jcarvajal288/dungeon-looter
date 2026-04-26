class_name WagonStorageBox extends Prop

func _ready() -> void:
    $InteractionArea.on_interaction.connect(on_interaction)


func on_interaction() -> void:
    StorageBoxScreen.toggle_storage_box_screen.emit()