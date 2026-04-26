class_name Horse extends Prop


func _ready() -> void:
    $InteractionArea.on_interaction.connect(on_interaction)


func on_interaction() -> void:
    EndScreen.end_game.emit()