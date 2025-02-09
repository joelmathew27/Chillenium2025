extends Node2D

@export var light := false
@export var bleed := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.last_spawned_point = position
		Signals.checkpoint_coords = position
		
		body.is_light_enabled = light
		body.is_bleeding = bleed
