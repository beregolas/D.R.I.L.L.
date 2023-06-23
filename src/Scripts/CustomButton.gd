extends Panel
@export var ButtonName = "Custom Button"
@export var highlightColor = Color(1.0, 0.2, 0.2, 1)
@export var highlightTime = 2
var standardColor = Color(1,1,1,1)


# Called when the node enters the scene tree for the first time.
func _ready():
	$Backgroundcolor/Name.text = ButtonName
	#select()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func select():
	$Backgroundcolor/Name.set_self_modulate(highlightColor)
	$AutoDeselect.start(1)


func deSelect():
	$Backgroundcolor/Name.set_self_modulate(standardColor)
	$AutoDeselect.stop()
	
func setText(text:String):
	$Backgroundcolor/Name.text = text
