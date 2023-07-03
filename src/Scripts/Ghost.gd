extends AnimatedSprite2D

@export var diff = Vector2(1000, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = get_parent().global_position + diff
	pass
