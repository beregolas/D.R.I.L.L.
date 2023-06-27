extends Area2D

@export var color = Color(0.0, 0.5, 0.5)
@export var horizontal_size:float = 3000
@export var vertical_size:float = 1000
var last_section
var next_section
var size:Vector2
@export var position_y:float = 0
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
	
	
func random_color():
	# Generate random color components
	var red = randf_range(0, 1)
	var green = randf_range(0, 1)
	var blue = randf_range(0, 1)
	var alpha = 1.0  # Set alpha to 1 for full opacity
	# Create a new random color
	var randomColor = Color(red, green, blue, alpha)
	return randomColor
func _draw():	
	print($Shape.shape.size)
	draw_rect(Rect2(Vector2(position_x, position_y), $Shape.shape.size), random_color())

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("ENTERED")
		#create the next section
		create_section()
		
func create_section():
	var section = load("res://Scenes/section.tscn").instantiate()
	section.position_y = self.position_y + self.vertical_size
	section.last_section = self
	get_tree().get_root().add_child(section)
	

func _on_body_exited(body):
	if body.is_in_group("player"):
		print("EXITED")
		if(last_section!= null):
			last_section.queue_free()
		

