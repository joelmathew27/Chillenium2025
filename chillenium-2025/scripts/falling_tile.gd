extends Node2D

var shaking := false
var rng = RandomNumberGenerator.new()
var shake_strength: float = 1.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StaticBody2D.collision_layer = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shaking:
		$AnimatedSprite2D.offset = Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$AudioStreamPlayer.play()
		shaking = true



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		await get_tree().create_timer(.5).timeout
		
		
		$StaticBody2D.collision_layer = 2
		$AnimationPlayer.play("fall")
		await $AnimationPlayer.animation_finished
		shaking = false
		$AudioStreamPlayer.stop()
	
