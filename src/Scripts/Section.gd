extends Area2D

@export var color = Color(0.0, 0.0, 0.5)
@export var size:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _draw():
	draw_rect(Rect2(Vector2(0., 0.), $Shape.shape.size), color)


func _on_body_entered(body):
	if body.is_in_group("player"):
		print("ENTERED")
		body.test_call("message_test")


func _on_body_exited(body):
	if body.is_in_group("player"):
		print("EXITED")

