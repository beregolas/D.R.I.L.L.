extends CanvasLayer
signal start_game
signal settings
signal exit

var main
var instance
var Highscore = "Highscore: "
var numberScore:Array = [1337]
var Buttons:Array
var chosenButton = 0
var animation = true

# Called when the node enters the scene tree for the first time.
func _ready():
	load_highScore()

	Buttons = $ButtonsContainer.get_children()
	if(animation):
		$NextButtonTimer.start(0.3)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("TheOnlyAction"):
		var name = Buttons[(chosenButton - 1) % Buttons.size()].ButtonName
		print(name)
		if(name=="Start"):
			start_game.emit()
		if(name=="Settings"):
			add_highscore(int(ceil(randf_range(100, 3000))))
			settings.emit()
		if(name=="Exit"):
			Buttons[(chosenButton - 1) % Buttons.size()].setText( "Bye bye")
			save_highscore()
			exit.emit()
			
			

func add_highscore(score):
	numberScore.append(int(score))
	numberScore.sort()
	numberScore.reverse()
	while(numberScore.size() > 10):
		numberScore.pop_back()
	Highscore = "Highscore: "
	for i in numberScore:
		add_score("Dr. Ill - " + str(i))
	display_highScore()
	

func add_score(score):
	Highscore += "\n" + score
	
func display_highScore():
	$Highscore.text = Highscore
	
func cycle_through_menu():
	if(animation):
		if(chosenButton+1 == Buttons.size()):
			$NextButtonTimer.start(1.5)
			animation = false
		else:
			Buttons[chosenButton].highlightTime = 0.25
			
	Buttons[chosenButton].select()
	chosenButton = (chosenButton + 1) % Buttons.size()
		
	
	
		
		
func save_highscore():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var node_data
	for number in range(numberScore.size()):
		node_data = {str(number) : numberScore[number]}

	# JSON provides a static method to serialized JSON string.
	var json_string = JSON.stringify(node_data)
	# Store the save dictionary as a new line in the save file.
	save_file.store_line(json_string)
	
		
# Note: This can be called from anywhere inside the tree. This function
# is path independent.
func load_highScore():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.


	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()
		print(node_data)
		
	
	
	
