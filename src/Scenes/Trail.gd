extends Line2D
var target
var point
var finished = false
@export var trail_length = 3000
@export var targetPath:NodePath

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node(targetPath)
	pass # Replace with function body.

func hit():
	print("backmodulation")
	modulate = Color(1,1,1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	point = target.global_position
	#finished is set when the player leaves the screen
	#print(point.y)
	if !finished:
		add_point(point)
	while get_point_count()>trail_length:
		remove_point(0)
		
