extends Node


@onready var audio_player = $AudioPlayer
@onready var transition = $TransitionScreen

var paused := false
var song := 0
var song1 = load("res://assets/track1.wav")
var song2 = load("res://assets/track2.wav")
#var song3 = load()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_player.stream = song1
	audio_player.play()
	Signals.changeScene.connect(changeScene)
	Signals.transition.connect(callTransition)
	Signals.die.connect(death)
	
	var menu = load("res://scenes/loading_screen.tscn").instantiate()
	menu.get_child(3).play("logos")
	add_child(menu)
	
	
	await get_tree().create_timer(5).timeout
	changeScene("res://scenes/main_menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	
	match song:
		0: pass
		1: 
			if audio_player.stream != song2:
				audio_player.stop()
				audio_player.stream = song2
				await get_tree().create_timer(2)
				audio_player.play()
		#2: 
			#if audio_player.stream != song3:
				#audio_player.stop()
				#audio_player.stream = song3
				#audio_player.play()

func changeScene(filepath : String):
	var temp_scene = load(filepath).instantiate()
	var temp_string : String = ""
	#print(temp_scene.name.substr(0,5))
	#print(temp_scene.name)
	if temp_scene.name.substr(0, 5) == "Level":
		temp_string = temp_scene.name
	
	if temp_string == "Level2":
		song+=1
	
	
	callTransition(Color(0,0,0))
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

func callTransition(color : Color):
	transition.color_rect.color = color
	transition.transition()

func death():
	var filepath = get_child(2).scene_file_path
	print(filepath)
	changeScene(filepath)
