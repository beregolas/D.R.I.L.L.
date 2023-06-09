extends CanvasLayer

var bonusPoints = 0
var depthPoints = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func announce(mood:String, text:String):
	set_subtitle(text)
	set_mood_zark(mood)
	setup_speech()

func keep_track_of_bonusScore(current_total_bonus):
	self.bonusPoints = current_total_bonus

func get_total_score():
	return depthPoints+bonusPoints

func update_score(player_pos):
	depthPoints = int(player_pos/100)*10
	var score = depthPoints + bonusPoints
	$ProgressBar.value = abs(player_pos)
	#print($ProgressBar.value,"/",$ProgressBar.max_value)
	$ScoreLabel.text = str(score)
	$ScoreLabel.show()

func init_progress_bar(total_vertical_pixels):
	$ProgressBar.max_value = total_vertical_pixels
	
	

func set_subtitle(newSubtitle:String):
	$Subtitles.text = newSubtitle

func setup_speech():
	show_zark(true)
	show_subtitles(true)

func show_zark(shown:bool):
	$Zark.visible = shown

func show_subtitles(shown:bool):
	$Subtitles.visible = shown
	
func set_mood_zark(mood:String = "normal"):
	mood = mood.to_lower()
	if(mood != "angry" && mood != "normal" && mood != "happy"):
		mood = "normal"
	$Zark.animation = mood
