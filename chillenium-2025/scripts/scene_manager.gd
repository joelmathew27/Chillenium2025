extends Node

@onready var audio_player = $AudioPlayer
@onready var transition = $TransitionScreen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_player.play()
	Signals.changeScene.connect(changeScene)
	Signals.transition.connect(callTransition)
	
	var menu = load("res://scenes/loading_screen.tscn").instantiate()
	add_child(menu)
	
	await get_tree().create_timer(3).timeout
	changeScene("res://scenes/test_world.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func changeScene(filepath : String):
	callTransition(Color(0,0,0))
	await Signals.onTransitionFinished
	
	get_child(2).queue_free()
	var game_scene = load(filepath).instantiate()
	add_child(game_scene)

func callTransition(color : Color):
	transition.color_rect.color = color
	transition.transition()
