extends Node
var score:int
var rocks = []
var collisionsCounter:int

# Called when the node enters the scene tree for the first time.
func _ready():
	$RigidBodyPlayer.freeze = true
	new_game()
	$Overlay.show()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func new_game():
	$Overlay.show_zark(false)
	score = 0
	$Overlay.update_score(score)
	instantiate_rocks(20, 000, 900, 100, 10000) # amount=10, min_x=0, max_x=900, min_y=100, max_y=10000
		
func instantiate_rocks(amountofRocks:int, min_x:float, max_x:float, min_y:float, max_y:float):
	var scene = load("res://Scenes/Rock.tscn")
	for i in range(amountofRocks):
		var rock = scene.instantiate()
		rock.position =  Vector2(randf_range(min_x,max_x), randf_range(min_y, max_y))
		rock.collision.connect(scoldPlayer)
		add_child(rock)
		rocks.append(rock)
	

func scoldPlayer():
	collisionsCounter += 1
	if(collisionsCounter<3):
		var scoldings = ["You fool!",
						"You should NOT hit the rocks!", 
						"Open your Eyes!",
						"Are you even watching?",
						"Even my Grandmother could do this better..."
						]
		$Overlay.announce("Angry", scoldings.pick_random())
	
	if(collisionsCounter==3):
		$Player.apply_torque_impulse(500000)
		$Player.add_constant_force(Vector2(0, -4*$Player.linear_velocity.y))
		$Overlay.set_subtitle("You failed!\nMaybe you succeed next time.")
	$Overlay.setup_speech()
	$ScoldTimer.start(3)
	
	# This is so high, because the torq turns the player so they object phases
	# in and out of the stone, counting it as multiple collisions
	if(collisionsCounter>40): 
		_hideScolding()

			
func _hideScolding():
	print("Hide scolidng")
	$Overlay.show_zark(false)
	$Overlay.show_subtitles(false)
	if(collisionsCounter>=3):
		returnToMenu()

func returnToMenu():
	save_highscore()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func updateScore():
	score = int($Player.position.y/100)*10
	$Overlay.update_score(score)
	#$RigidBodyPlayer.freeze = false
	
	if(score > 1000 && score < 1200):
		print("Victory Message")
		$Overlay.announce("Happy", "Well done Dr. Ill!
		Soon the world will burn and everyone will live on the moon")
		$ScoldTimer.start(5)
	if(score > 1180 && score < 1300):
		returnToMenu()
		


func save_highscore():
	var highscore = load_highScore()
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	# We have to retreive and write the old scores again
	# I do not understand, why there is not an easy "append" option
	for score in highscore:
		save_file.store_line(str(score))
	save_file.store_line(str(score)) # current player score
	save_file.close()
	
		
# Note: This can be called from anywhere inside the tree. This function
# is path independent.
func load_highScore():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	var highscores = []
	while save_game.get_position() < save_game.get_length():
		highscores.append(save_game.get_line())
	save_game.close()	
	return highscores
		
