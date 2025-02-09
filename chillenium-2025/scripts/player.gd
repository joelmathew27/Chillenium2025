extends CharacterBody2D



var last_spawned_point : Vector2
var is_seeing = false
var is_dead = false
var cutscene = false

var normal_frames = load("res://misc/player_normal.tres")
var bleed_frames = load("res://misc/player_bleed.tres")

@export var is_light_enabled = false
@export var is_bleeding = false

const SPEED = 100.0

func _ready() -> void:
	$ChilleniumPlayer.play("default")
	$ChilleniumPlayer.material.set("shader_parameter/on", true)
	$PointLight2D.enabled = is_light_enabled
	if Signals.checkpoint_coords:
		position = Signals.checkpoint_coords

func _process(delta: float) -> void:
	$PointLight2D.enabled = is_light_enabled
	
	if is_bleeding:
		$ChilleniumPlayer.sprite_frames = bleed_frames
	else:
		$ChilleniumPlayer.sprite_frames = normal_frames
	
	
	if !cutscene:
		
		
		$Eye.visible = is_seeing
		if is_seeing:
			$ChilleniumPlayer.play("default")
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

	
	if !cutscene :
	
		if Input.is_action_just_pressed("use_eye"):
			if !is_seeing:
				$Eye/AudioStreamPlayer.play()
			is_seeing = !is_seeing
		
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		if !is_seeing and !is_dead:
			var direction := Input.get_vector("a", "d", "w", "s")
			if direction:
				velocity = direction * SPEED
				
				if direction.x > 0:
					$ChilleniumPlayer.play("right_walk")
				elif direction.x < 0:
					$ChilleniumPlayer.play("left_walk")
				elif direction.y < 0:
					$ChilleniumPlayer.play("up_walk")
				elif direction.y > 0:
					$ChilleniumPlayer.play("down_walk")
				
			else:
				$ChilleniumPlayer.play("default")
				velocity.x = move_toward(velocity.x, 0, SPEED)
				velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
	


func _on_feet_area_body_entered(body: Node2D) -> void:
	velocity = Vector2.ZERO
	is_dead = true
	$AnimationPlayer.play("die")
	await $AnimationPlayer.animation_finished
	Signals.emit_signal("die")
