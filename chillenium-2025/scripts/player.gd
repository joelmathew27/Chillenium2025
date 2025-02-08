extends CharacterBody2D

var is_seeing = false
@export var is_light_enabled = false

const SPEED = 150.0

func _ready() -> void:
	$ChilleniumPlayer.play("default")
	$PointLight2D.enabled = is_light_enabled

func _process(delta: float) -> void:
	$Eye.visible = is_seeing
	if is_seeing:
		velocity = Vector2.ZERO
		$ChilleniumPlayer.material.set("shader_parameter/on", false)
		$Eye.position = get_local_mouse_position()
		$CPUParticles2D.position = $Eye.position
		$CPUParticles2D.emitting = true
		#$Camera2D.position = $Eye.position
	else:
		#$Camera2D.position = position
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
			$ChilleniumPlayer.play("walk")
			velocity = direction * SPEED
			$ChilleniumPlayer.flip_h = velocity.x < 0
		else:
			$ChilleniumPlayer.play("default")
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
	


func _on_feet_area_body_entered(body: Node2D) -> void:
	print("dead")
