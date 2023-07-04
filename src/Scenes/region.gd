extends Area2D

signal milestoneReached

var max_number_of_regions:int = 12
var current_region_number:int = 1
var colors:Array[Color] = [
	Color(0.8, 1, 1),
	Color(0.8, 1.1, 1.7),
	Color(0.8, 1.5, 2.2),
	Color(1.5, 1.5, 2.5),
	Color(0.5, 1.2, 1.),
	Color(1.0, 0.9, 0.9),
	Color(1.3, 0.8, 0.9),
	Color(1., 1.2, 0.8),
	Color(1.5, 1.4, 0.6),
	Color(1.7, 0.8, 0.9),
	Color(1.9, 1.5, 0.8),
	Color(2.0, 0.3, 0.5),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate_color()
	#$shape.shape.size.x = 3000
	#$shape.shape.size.y = 1000
	$Notifier.rect.size.y = $shape.shape.size.y + 300
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_start_position():
	return self.transform.origin.y
	
func get_end_position():
	return get_start_position() + $shape.shape.size.y


func create_next_region():
	var next_region = load("res://Scenes/region.tscn").instantiate()
	next_region.transform.origin.y = get_end_position()-10
	next_region.current_region_number= self.current_region_number+1
	get_parent().add_child(next_region)
	milestoneReached.connect(get_parent().reachingMilestone)
	

func modulate_color():
	$earthcore.hide()
	var color_index = (max_number_of_regions - current_region_number / max_number_of_regions)
	if current_region_number != max_number_of_regions:
		modulate = colors[(current_region_number-1)%colors.size()]
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
 

func _on_body_exited(body):
	pass
	
func win_if_last_region():
	if current_region_number==max_number_of_regions:
		var player = get_parent().get_node("Player")
		player.get_node("Trail").hide()
		player.drilling_speed = 70
		player.rotation_speed = 0.8
		player.get_node("Trail").trail_length = 0
		get_parent().win()
		$explosion_animations.explode()
		#queue_free()
		return true


func _on_notifier_screen_exited():
	print("region exited screen")
	queue_free()
	pass # Replace with function body.
