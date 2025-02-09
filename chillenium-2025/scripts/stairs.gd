extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$AudioStreamPlayer.play()
		
		var next_level = (get_parent().name).to_lower()
		var level_num = int(next_level.substr(next_level.length()-1, 1)) + 1
		next_level = next_level.left(-1) + "_" + str(level_num)
		print(next_level)
		Signals.checkpoint_coords = Vector2.ZERO
		Signals.emit_signal("changeScene", "res://scenes/" + next_level + ".tscn")
