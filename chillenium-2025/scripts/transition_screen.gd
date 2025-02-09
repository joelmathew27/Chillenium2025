extends CanvasLayer

@onready var anim_player = $AnimationPlayer
@onready var color_rect = $ColorRect

func _ready() -> void:
	color_rect.visible = false
	anim_player.animation_finished.connect(_on_animation_finished)
	
	
func transition():
	color_rect.visible = true
	anim_player.play("fade_to")

func _on_animation_finished(anim_name):
	if anim_name == "fade_to":
		Signals.onTransitionFinished.emit()
		anim_player.play("fade_out")
	elif anim_name == "fade_out":
		color_rect.visible = false
	
