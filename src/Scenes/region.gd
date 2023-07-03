extends Area2D

signal milestoneReached

var last_region = null
var max_number_of_regions:int = 12
var current_region_number:int = 1
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
	next_region.current_region_number= self.current_region_number+1
	get_parent().add_child(next_region)
	milestoneReached.connect(get_parent().reachingMilestone)
	

func modulate_color():
	$earthcore.hide()
	var blue_hue = randf_range(0,1)
	var green_hue = randf_range(0,1)
	var red_hue = randf_range(0,1)
	if current_region_number != max_number_of_regions:
		
		$texture.modulate = Color(red_hue, green_hue,blue_hue )
	else:
		$explosion_animations.show()
		$earthcore.show()
		
		#$texture.material.set_shader(load("res://shader/region.gdshader"))
		
		
	
func get_total_length():
	return (max_number_of_regions-1) * $shape.shape.size.y + 800
	
	
func _on_body_entered(body):
	if body.is_in_group("player") and not body.is_in_group("player2"):
		change_player_movement()
		if win_if_last_region():
			return
		else:
			create_next_region()
		if( current_region_number==int(0.25*max_number_of_regions) ||
			current_region_number==int(0.5 *max_number_of_regions) ||
			current_region_number==int(0.75*max_number_of_regions)):
			print("Signal emitted. Current region ", current_region_number, "of ", max_number_of_regions)
			milestoneReached.emit()
		
		
func change_player_movement():
	get_parent().randomize_speed_and_rotation()
	

func delete_last_region():
	if self.last_region != null:
		last_region.queue_free()


func _on_body_exited(body):
	if body.is_in_group("player"):
		delete_last_region()
	
func win_if_last_region():
	if current_region_number==max_number_of_regions:
		var player = get_parent().get_node("Player")
		player.get_node("Trail").hide()
		player.drilling_speed = 7000
		player.rotation_speed = 80
		get_parent().win()
		if last_region !=null:
			last_region.queue_free()
		$explosion_animations.explode()
		#queue_free()
		return true
