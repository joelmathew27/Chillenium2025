extends Camera2D

var randomStrength: float = 5.0
var shakeFade: float = 30.0

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0

func _ready() -> void:
	pass

func applyShake():
	freeze_frame(.1, 1.5)
	shake_strength = randomStrength

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		
		offset = randomOffset()
		
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))

func freeze_frame(timeScale, duration):
	Engine.time_scale = timeScale
	await(get_tree().create_timer(duration * timeScale).timeout)
	Engine.time_scale = 1
