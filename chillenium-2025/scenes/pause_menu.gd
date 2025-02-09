extends Control

@onready var main = $"../"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_quit_pressed() -> void:
	Signals.emit_signal("changeScene", "res://scenes/main_menu.tscn")


func _on_resume_pressed() -> void:
	main.pauseMenu()


func _on_options_pressed() -> void:
	pass
