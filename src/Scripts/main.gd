extends Node
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	$RigidBodyPlayer.freeze = true
	#$TextureRect.hide()
	
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$Overlay.show_zark(true) # show only Zark
	#$Overlay.show_subtitles(true) # show only subtitles
	#$Overlay.set_mood_zark("Happy")
	#$Overlay.set_mood_zark("angry")
	#$Overlay.set_mood_zark("normal")
	#$Overlay.setup_speech() # Show Zark and Subtitle
	pass


func new_game():
	score = 0
	$RigidBodyPlayer.freeze = false
	$MainMenu.hide()
	#get_tree().call_group("obstacles", "queue_free")
	#$RigidBodyPlayer.start()
	$Overlay.update_score(score)
	#$TextureRect.show()
	#$RigidBodyPlayer.freeze = false
	#$MainMenu.hide()
	
