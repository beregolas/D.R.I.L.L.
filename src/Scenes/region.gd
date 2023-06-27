extends Area2D

var last_region = null

func _init():
	self.transform.origin.y = 400
	

	

# Called when the node enters the scene tree for the first time.
func _ready():
	$shape.shape.size.x = 3000
	$shape.shape.size.y = 100
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _draw():	
	pass

func get_start_position():
	return self.transform.origin.y
	
func get_end_position():
	return get_start_position() + $shape.shape.size.y


func create_next_region():
	var next_region = load("res://Scenes/region.tscn").instantiate()
	next_region.transform.origin.y = get_end_position()
	next_region.last_region = self
	get_parent().add_child(next_region)


func _on_body_entered(body):
	if body.is_in_group("player"):
		create_next_region()


func delete_last_region():
	print(self.last_region)
	if self.last_region != null:
		last_region.queue_free()


func _on_body_exited(body):
	if body.is_in_group("player"):
		delete_last_region()
	
