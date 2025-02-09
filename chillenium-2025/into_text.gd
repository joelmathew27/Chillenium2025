extends CanvasLayer

@export var text := ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
