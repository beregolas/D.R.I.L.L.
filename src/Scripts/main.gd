extends Node
var score:int
var bonus_score:int
var rocks = []
var obstacles = []
var collisionsCounter:int
var obstaclesPaths = ["res://Scenes/rock.tscn", "res://Scenes/garbage.tscn", "res://Scenes/lava.tscn", "res://Scenes/maggot.tscn", "res://Scenes/armadillo.tscn"]
var currentLine = 0
var lines = []
var goalTextPointer = 0
var reachedGoal = 0
var invincible:bool
var zarkVoices = []
var vertical_pixels = 0
var introLines = ["With the release of the gapple headset, the the downfall of earth is invetiable.",
	"To save humanity I have construced an moon base, but no one wants to go.",
	"So you simply have to blow up the earth so that everyone has to flee to my moonbase.",
	"Drill into golden bombs for extra points and avoid everything else.",
	"We only had money for a spacebar, so that is how you steer.",
	]

@export var is_multiplayer = false

@export var lives = 3	

@export var speeds: Array = [100, 150, 200, 220, 240, 260, 280, 300, 320, 350, 400]
@export var rotations: Array = [1.5, 1.4, 1.3, 1.2, 1.1, 1.1, 1.1, 1.0, 0.8, 0.6, 0.5]


# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	$Overlay.show()


func displaySpeech():
	if(currentLine==lines.size()):
		$longSpeechTimer.stop()
		_hideScolding()
		$ObstacleTimer.start(2)
		currentLine = 0
		invincible = false 
		return
	$Overlay.announce("normal", lines[currentLine])
	currentLine += 1

func holdSpeech(speechLines):
	lines = speechLines
	currentLine = 0
	$longSpeechTimer.start(4.3)
	$ObstacleTimer.start(50)
	displaySpeech()

	invincible = true
	
	
func introductorySpeech():
	
	holdSpeech(introLines)
	$"Player/Introductory Player".play()
	#$FollowCamera.camera_speed = lerp(0.005, 0.9, 0.05)
	#print("Lerping")
	
	
func reachingMilestone():
	print("GOAL!")
	var goalOneLines = [
		"Different earth layers cause different steering, as any non moogle employee might have noticed."
	]
	
	var goalTwoLines = [
		"Well, fellow human, until now you have managed to pull off a passable job there.",
		 
	]
	
	var goalThreeLines = [
		"You have almost saved the world from gapples advertising free heresy. This moon base will make me so much ad revenue"

	]
	
	var goaltexts = [goalOneLines, goalTwoLines, goalThreeLines]
	print("GoalTextpointer: ", goalTextPointer)
	if(!goalTextPointer>=goaltexts.size()):
		holdSpeech(goaltexts[goalTextPointer]) 
		zarkVoices[goalTextPointer].play()
		goalTextPointer += 1

func new_game():
	goalTextPointer = 0
	score = 0
	bonus_score = 0
	introductorySpeech()
	zarkVoices = [$"Player/zark voiceplayer 1", $"Player/zark voiceplayer 2", $"Player/zark voiceplayer 3"]
	$Overlay.update_score(score)
	init_first_region()
	


func init_first_region():
	var region = load("res://Scenes/region.tscn").instantiate()
	add_child(region)
	vertical_pixels = region.get_total_length()
	$Overlay.init_progress_bar(vertical_pixels)
	
### Generate a parametrazised amount of obstacles defined by path in a rectangle defined by min_x, max_x, min_y and max_y
func instantiate_obstacles(amountofObstacles:int, min_x:float, max_x:float, min_y:float, max_y:float, path:String ):
	if($ObstacleTimer.wait_time==2):
		print("Wait time: ", $ObstacleTimer.wait_time)
		$ObstacleTimer.start(10)
	var scene = load(path)
	for i in range(amountofObstacles):
		var obstacle = scene.instantiate()
		obstacle.position = Vector2(randf_range(min_x,max_x), randf_range(min_y, max_y))
		obstacle.collision.connect(looseLife)
		add_child(obstacle)
		obstacles.append(obstacle)

func instantiate_collectibles():
	var maximum_collectibles = 5
	var min_x = 0
	var max_x = get_viewport().size.x
	var min_y = $FollowCamera.position.y + get_viewport().size.y
	var max_y = min_y + get_viewport().size.y*5
	get_viewport().size.x
	var collectible_scene = load("res://Scenes/collectibles.tscn")
	for i in range(maximum_collectibles):
		var collectible = collectible_scene.instantiate()
		collectible.position = Vector2(randf_range(min_x,max_x), randf_range(min_y, max_y))
		collectible.collected.connect(on_collect)
		add_child(collectible)
	
	
func randomize_speed_and_rotation():
	# find speed randomly
	var i = randi_range(0, speeds.size()-1)
	var j = clampi(i + randi_range(-4, 4), 0, speeds.size()-1)
	get_tree().call_group("player", "set_speed_and_rotation", speeds[i], rotations[j])
	
	
	
	
func on_collect():
	bonus_score = bonus_score+500
	$Overlay.keep_track_of_bonusScore(bonus_score)
	
	
### Display Zark Muckerberg and show messages scolding the player for hitting objects
### Also checks if the maximum number of collisions was reached and initiates playerdeath
func looseLife():
	print("life lost")
	if(invincible):
		return
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

	if(collisionsCounter>=lives):
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
	$Overlay.update_score($Player.position.y)
	#we could just send signal directly to overlay but I don't know how to do that
	


func win():
	print("you win")
	invincible = true
	# get_tree().call_group("player", "die")
	#$"Player/wohoo".play()
	$Player/OutroText.play()
	get_tree().call_group("player", "set_speed_and_rotation", $Player.drilling_speed, 0.1)
	$Overlay.announce("Happy", "You did it. You blew up earth. You saved everyone from the heretical gapple and their adblockers. Good job, you may now die.")
	$ScoldTimer.start(5)
	$GameOverDelayTimer.start(15)
	pass


### Together with load_highscore saves the current highscore to the end of the highscore file
func save_highscore():
	var highscore = load_highScore()
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	# We have to retreive and write the old scores again
	# I do not understand, why there is not an easy "append" option
	for score in highscore:
		save_file.store_line(str(score))
	save_file.store_line(str($Overlay.get_total_score())) # current player score
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
	print("Generating obstacles	")
	var min_pos = $FollowCamera.position.y + get_viewport().size.y
	var max_pos = min_pos + get_viewport().size.y*5
	var maxObsticlesPerScreen = 30
	var amount_of_type:int
	instantiate_collectibles()
	if(vertical_pixels<min_pos + get_viewport().size.y*5):
		print("End in sight!")
		$ObstacleTimer.start(60)
		max_pos = vertical_pixels
		maxObsticlesPerScreen = 15
	for i in range(5):
		amount_of_type = randi_range(1, 5)
		if(maxObsticlesPerScreen<amount_of_type):
			instantiate_obstacles(maxObsticlesPerScreen, 0, get_viewport().size.x, min_pos, max_pos, obstaclesPaths[i])
			maxObsticlesPerScreen = 0
		else:	
			maxObsticlesPerScreen -= amount_of_type
			instantiate_obstacles(amount_of_type, 0, get_viewport().size.x, min_pos, max_pos, obstaclesPaths[i])
