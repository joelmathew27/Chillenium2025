extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.cutscene = true
	$AnimationPlayer.play("cutscene")
	$Player/ChilleniumPlayer.play("right_walk")
	await get_tree().create_timer(3).timeout
	$Player/ChilleniumPlayer.stop()
	$Player/ChilleniumPlayer.flip_h = true
	await get_tree().create_timer(.7).timeout
	$Player/Camera2D.applyShake()
	await get_tree().create_timer(1.5).timeout
	$Player/ChilleniumPlayer.flip_h = false
	await get_tree().create_timer(.4).timeout
	$Player.cutscene = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func shakeScreen(camera : Camera2D):
	pass


func _on_fade_out_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$Player.cutscene = true
		$AnimationPlayer.play("fade_out_cahr")
		$Player.velocity = Vector2(1,0) * 100
		$Player/ChilleniumPlayer.play("right_walk")
