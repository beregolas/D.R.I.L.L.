extends Node
var score:int
var rocks = []
var obstacles = []
var collisionsCounter:int
var obstaclesPaths = ["res://Scenes/rock.tscn", "res://Scenes/garbage.tscn", "res://Scenes/lava.tscn", "res://Scenes/maggot.tscn", "res://Scenes/armadillo.tscn"]

@export var lives = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	$Overlay.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func new_game():
	$Overlay.show_zark(false)
	score = 0

	$Overlay.update_score(score)
	var region = load("res://Scenes/region.tscn").instantiate()
	add_child(region)
	#Rocks # amount=10, min_x=0, max_x=900, min_y=100, max_y=10000
#	instantiate_obstacles(20, 0, 900,   100, 10000, "res://Scenes/rock.tscn")
#	instantiate_obstacles(100, 0, 900, 0, 15000, "res://Scenes/garbage.tscn")
#	instantiate_obstacles(20, 0, 900, 10000, 15000, "res://Scenes/lava.tscn")
#	instantiate_obstacles(100, 0, 900, 0, 20000, "res://Scenes/maggot.tscn")
#	instantiate_obstacles(300, 0, 900, 0, 23000, "res://Scenes/armadillo.tscn")
	$ObstacleTimer.start()


### Generate a parametrazised amount of obstacles defined by path in a rectangle defined by min_x, max_x, min_y and max_y
func instantiate_obstacles(amountofObstacles:int, min_x:float, max_x:float, min_y:float, max_y:float, path:String ):
	var scene = load(path)
	for i in range(amountofObstacles):
		var obstacle = scene.instantiate()
		obstacle.position = Vector2(randf_range(min_x,max_x), randf_range(min_y, max_y))
		obstacle.collision.connect(looseLife)
		add_child(obstacle)
		obstacles.append(obstacle)


### Display Zark Muckerberg and show messages scolding the player for hitting objects
### Also checks if the maximum number of collisions was reached and initiates playerdeath
func looseLife():
	collisionsCounter += 1
	$Player.hit()
	if(collisionsCounter<lives):
		var scoldings = ["You fool!",
						"You should NOT hit those!",
						"Open your Eyes!",
						"Are you even watching?",
						"Even my Grandmother could do this better..."
						]
		$Overlay.announce("Angry", scoldings.pick_random())

	if(collisionsCounter==lives):
		$Player.die()
		$GameOverDelayTimer.start()
		$Overlay.set_subtitle("You failed!\nMaybe you succeed next time.")
	$Overlay.setup_speech()
	$ScoldTimer.start(3)

### This hides the face of Zark and overlay text again, when $ScoldTimer triggers
func _hideScolding():
	$Overlay.show_zark(false)
	$Overlay.show_subtitles(false)


### This adds the current highscore to the saved highscores
### Then returns to the main menu scene
func returnToMenu():
	save_highscore()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

# Updates the displayed score every second
# Displays the Victory Message based on the score
func updateScore():
	score = int($Player.position.y/100)*10
	$Overlay.update_score(score)


func win():
	print("you win")
	$Overlay.announce("Happy", "Well done Dr. Ill!
		Soon the world will burn and everyone will live on the moon")
	$ScoldTimer.start(5)
	$GameOverDelayTimer.start(5)
	
	pass


### Together with load_highscore saves the current highscore to the end of the highscore file
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
### Together with save_highscore saves the current highscore to the end of the highscore file
func load_highScore():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	var highscores = []
	while save_game.get_position() < save_game.get_length():
		highscores.append(save_game.get_line())
	save_game.close()
	return highscores



func _on_obstacle_timer_timeout():
	var min_pos = $FollowCamera.position.y + get_viewport().size.y
	var maxObsticlesPerScreen = 30
	var amount_of_type:int
	for i in range(5):
		amount_of_type = randi_range(1, 5)
		if(maxObsticlesPerScreen<amount_of_type):
			instantiate_obstacles(maxObsticlesPerScreen, 0, get_viewport().size.x, min_pos, min_pos + get_viewport().size.y*5, obstaclesPaths[i])
			maxObsticlesPerScreen = 0
		else:	
			maxObsticlesPerScreen -= amount_of_type
			instantiate_obstacles(amount_of_type, 0, get_viewport().size.x, min_pos, min_pos + get_viewport().size.y*5, obstaclesPaths[i])
