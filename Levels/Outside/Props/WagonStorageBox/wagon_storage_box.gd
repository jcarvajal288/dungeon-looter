class_name WagonStorageBox extends Prop


func on_interaction() -> void:
    StorageBoxScreen.toggle_storage_box_screen.emit()