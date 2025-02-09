extends Control



func _on_start_pressed() -> void:
	Signals.emit_signal("changeScene", "res://scenes/level_0.tscn")



func _on_options_pressed() -> void:
	Signals.emit_signal("changeScene", "res://scenes/settings.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
