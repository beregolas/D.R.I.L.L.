extends Area2D

@export var color = Color(0.0, 0.5, 0.5)
@export var horizontal_size:float = 3000
@export var vertical_size:float = 20
var last_section
var next_section
var size:Vector2
@export var position_y:float = 500
var position_x:float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Shape.shape.size = size
	size= Vector2(horizontal_size,vertical_size)
	$Shape.shape.size = size
	$Shape.transform.origin = Vector2(position_x, position_y)
	print("create scene at ",position_x)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
	
func _draw():	
	print($Shape.shape.size)
	draw_rect(Rect2(Vector2(position_x, position_y), $Shape.shape.size), color)

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("ENTERED")
		body.test_call("message_test")


func _on_body_exited(body):
	if body.is_in_group("player"):
		print("EXITED")

