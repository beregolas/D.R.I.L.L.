extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func announce(mood:String, text:String):
	set_subtitle(text)
	set_mood_zark(mood)
	setup_speech()

func update_score(score):
	$ScoreLabel.text = str(score)
	$ScoreLabel.show()

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
