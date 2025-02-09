extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StaticBody2D.collision_layer = 0
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$AnimatedSprite2D.play("shaking")
		print("shaking")



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$AnimatedSprite2D.play("default")
		await get_tree().create_timer(.5).timeout
		
		
		$StaticBody2D.collision_layer = 2
		$AnimationPlayer.play("fall")
	
