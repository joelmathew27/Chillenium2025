extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.cutscene = true
	$CanvasLayer/AnimationPlayer.play("fade")
	await get_tree().create_timer(3.5).timeout
	$Player.cutscene = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
