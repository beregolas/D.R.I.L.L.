extends Control
var camera 

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_parent().get_node("FollowCamera")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	custom_minimum_size = Vector2()
	
