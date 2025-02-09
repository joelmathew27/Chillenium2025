extends Node

@onready var audio_player = $AudioPlayer
@onready var transition = $TransitionScreen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_player.play()
	Signals.changeScene.connect(changeScene)
	Signals.transition.connect(callTransition)
	Signals.die.connect(death)
	
	var menu = load("res://scenes/loading_screen.tscn").instantiate()
	add_child(menu)
	
	await get_tree().create_timer(3).timeout
	changeScene("res://scenes/level_0.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func changeScene(filepath : String):
	var temp_scene = load(filepath).instantiate()
	var temp_string : String = ""
	#print(temp_scene.name.substr(0,5))
	#print(temp_scene.name)
	if temp_scene.name.substr(0, 5) == "Level":
		temp_string = temp_scene.name
	
	match(temp_string):
		"Level0":
			temp_string = "The Beginning"
		"Level1":
			temp_string = "Trials of Trickery"
		"Level2":
			temp_string = "Mastering the Maze"
		"Level3":
			temp_string = "Nearing a Close"
		"Level4":
			temp_string = "The End in Sight"
	
	
	callTransition(Color(0,0,0), temp_string)
	await Signals.onTransitionFinished
	
	get_child(2).name = "to be deleted"
	get_child(2).queue_free()
	var game_scene = load(filepath).instantiate()
	
	add_child(game_scene)
	#print(game_scene.name + "Before")
	if temp_string != "" and game_scene.name != temp_string:
		#print(temp_string)
		game_scene.name = str(temp_string)
		#print(game_scene.name + "After")

func callTransition(color : Color, label_text : String):
	transition.color_rect.color = color
	transition.transition(label_text)

func death():
	var filepath = get_child(2).scene_file_path
	print(filepath)
	changeScene(filepath)
	
