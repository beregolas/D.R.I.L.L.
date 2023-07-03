extends CharacterBody2D

@export var drilling_speed = 70
@export var action = "TheOnlyAction"
var screen_size
@export var rotation_speed = 0.8
@export var maximum_angle = 80
var heat_color = 1
@export var self_color = 1.0
var current_trail = null
var speed_factor = 100
var alive = true

var debug = false
var death_rotation = 0
var death_direction = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	if debug:
		debug_run()
	current_trail = $Trail
	$Sprite.play()
	$Sprite.speed_scale = 5
	self.modulate = Color(self_color,heat_color,heat_color)
	print("Ready called")
	pass # Replace with function body.


func debug_run():
	drilling_speed = 30000
	get_parent().lives = 1000
	rotation_speed = 0

#function that gets called when the player gets hit, makes the drill more red
func hit():
	get_tree().call_group("player", "_hit")

func _hit():
	heat_color= heat_color-0.3
	self.modulate = Color(self_color,heat_color,heat_color)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(self.position.y < 560):
		self.position.y += 1
		$Trail.trail_length = 0
		return
	else:
		$Trail.trail_length = 3000
		$Trail.visible = true
		
	if(self.drilling_speed>=25000):
		$Sprite.speed_scale = 3
	elif(drilling_speed<25000 && drilling_speed>500):
		$Sprite.speed_scale = 1
		
		
	
		
	# check for doodle jump warp
	if self.position.x < 0:
		self.position.x += 1000
		create_new_trail()
	elif self.position.x > 1000:
		self.position.x -= 1000
		create_new_trail()
	if alive:
		# check for rotation direction
		var rotation_direction = -1 if Input.is_action_pressed(action) else 1 
		# update rotation
		self.rotation_degrees = max(min(self.rotation_degrees + rotation_direction * rotation_speed * speed_factor * delta, maximum_angle), -maximum_angle)
		#print(rotation_degrees)
		velocity = transform.y * drilling_speed * delta * speed_factor
		move_and_slide()
	else:
		self.rotation_degrees += death_rotation * delta
		self.position += death_direction * delta
		

func set_speed_and_rotation(speed, rotation):
	self.drilling_speed = speed
	self.rotation_speed = rotation

func create_new_trail():
	current_trail.finished = true
	var new_trail = current_trail.duplicate()
	new_trail.finished = false
	new_trail.clear_points()
	current_trail = new_trail
	add_child(new_trail)

func test_call(message):
	print(message)


	
func die():
	self.drilling_speed = 1
	$Sprite.speed_scale = 0.2
	self.death_rotation = randf_range(-60, 60)
	self.death_direction = Vector2(randf_range(-8, 8), randf_range(-8, 8))
	self.alive = false
	$Collider.disabled = false
