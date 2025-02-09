extends CanvasLayer

@onready var anim_player = $AnimationPlayer
@onready var color_rect = $ColorRect

func _ready() -> void:
	color_rect.visible = false
	$Label.visible = false
	anim_player.animation_finished.connect(_on_animation_finished)
	
	
func transition(label_text : String):
	$Label.text = label_text
	color_rect.visible = true
	$Label.visible = true
	anim_player.play("fade_to")

func _on_animation_finished(anim_name):
	if anim_name == "fade_to":
		await get_tree().create_timer(2).timeout
		Signals.onTransitionFinished.emit()
		anim_player.play("fade_out")
	elif anim_name == "fade_out":
		color_rect.visible = false
		$Label.visible = false
	
