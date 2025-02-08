extends CharacterBody2D

var is_seeing = false

const SPEED = 150.0

func _ready() -> void:
	$ChilleniumPlayer.stop()

func _process(delta: float) -> void:
	$Eye.visible = is_seeing
	if is_seeing:
		$ChilleniumPlayer.stop()
		$ChilleniumPlayer.material.set("shader_parameter/on", false)
		$Eye.position = get_local_mouse_position()
		$CPUParticles2D.position = $Eye.position
		$CPUParticles2D.emitting = true
	else:
		$ChilleniumPlayer.play("walk")
		$ChilleniumPlayer.material.set("shader_parameter/on", true)
		$CPUParticles2D.emitting = false

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("use_eye"):
		is_seeing = !is_seeing
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if !is_seeing:
		var direction := Input.get_vector("a", "d", "w", "s")
		if direction:
			velocity = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
	
