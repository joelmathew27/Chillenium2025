extends Control

@onready var volume_slider = $MarginContainer/VBoxContainer/HSlider
var fullscreen : bool

func _ready() -> void:
	if DisplayServer.window_get_mode(0) == DisplayServer.WINDOW_MODE_FULLSCREEN:
		fullscreen = true
	else:
		fullscreen = false
	
	volume_slider.value = AudioServer.get_bus_volume_db(0)
	$MarginContainer/VBoxContainer/CheckButton.button_pressed = fullscreen



func _on_option_button_item_selected(index: int) -> void:
	if fullscreen == false:
		match index:
			0:
				DisplayServer.window_set_size(Vector2i(1920,1080))
			1:
				DisplayServer.window_set_size(Vector2i(1600,900))
			2:
				DisplayServer.window_set_size(Vector2i(1280,720))
			3:
				DisplayServer.window_set_size(Vector2i(640,360))


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		fullscreen = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		fullscreen = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_back_button_pressed() -> void:
	Signals.emit_signal("changeScene", "res://scenes/main_menu.tscn")


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)
