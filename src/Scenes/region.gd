extends Area2D

var last_region = null
#size of region is set in the shape.shape menu
func _init():
	pass
	

	

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate_color()
	#$shape.shape.size.x = 3000
	#$shape.shape.size.y = 1000
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
	next_region.transform.origin.y = get_end_position()-10
	next_region.last_region = self
	get_parent().add_child(next_region)

func modulate_color():
	var blue_hue = randf_range(0.5,1)
	var green_hue = randf_range(0.5,1)
	var red_hue = randf_range(0.5,1)
	$texture.modulate = Color(blue_hue, green_hue, red_hue)
	

func _on_body_entered(body):
	
	print("entered new region")
	if body.is_in_group("player"):
		change_player_movement()
		create_next_region()
		
func change_player_movement():
	var player = get_parent().get_node("Player")
	player.drilling_speed = player.drilling_speed*1.5
	player.rotation_speed = player.rotation_speed + randf_range(-10,10)

func delete_last_region():
	if self.last_region != null:
		last_region.queue_free()


func _on_body_exited(body):
	if body.is_in_group("player"):
		delete_last_region()
	
