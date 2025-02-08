extends Node2D

@export var Plank : Node2D = Node2D.new()
var ready_to_press := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Plank.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ready_to_press:
		if Input.is_action_just_pressed("interact"):
			Plank.visible = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		ready_to_press = true



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		ready_to_press = false
