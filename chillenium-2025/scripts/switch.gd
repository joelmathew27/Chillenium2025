extends Node2D

@export var Plank : Node2D = Node2D.new()
var ready_to_press := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Plank.visible = false
	$Sprite2D.play("off")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ready_to_press:
		if Input.is_action_just_pressed("interact"):
			
			Plank.visible = true
			
			$Sprite2D.play("switch")
			$AudioStreamPlayer.play()
			await $Sprite2D.animation_finished
			$Sprite2D.play("on")
			$Area2D.monitoring = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		ready_to_press = true



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		ready_to_press = false
