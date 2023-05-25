extends Label


var pressed_text = "The button IS pressed!"

var unpressed_text = "The button is NOT pressed!"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("TheOnlyAction"):
		self.text = self.pressed_text
	else:
		self.text = self.unpressed_text
	pass


func _on_button_down():
	pass
