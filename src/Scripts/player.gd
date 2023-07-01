extends CharacterBody2D

@export var drilling_speed = 70000 #speed pixels/sec
var screen_size
@export var rotation_speed = 100
@export var maximum_angle = 80
var current_trail = null
var speed_factor = 1.0
var alive = true
var speeds = [20000,30000,40000,50000,60000,70000]
var rotation_speeds = [60,80,120,200,300,400,500,600,700]
var low_rotation_speeds = [60,80,120,200]
var high_rotation_speeds = [400,500,600,700]
var low_speeds = [20000,30000,40000]
var high_speeds = [50000,60000,70000]

var death_rotation = 0
var death_direction = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	current_trail = $Trail
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# check for doodle jump warp
	if self.position.x < 0:
		
		self.position.x += 1000
		create_new_trail()
	elif self.position.x > 1000:
		
		self.position.x -= 1000
		create_new_trail()
	if alive:
		# check for rotation direction
		var rotation_direction = -1 if Input.is_action_pressed("TheOnlyAction") else 1 
		# update rotation
		self.rotation_degrees = max(min(self.rotation_degrees + rotation_direction * rotation_speed * delta, maximum_angle), -maximum_angle)
		#print(rotation_degrees)
		velocity = transform.y * drilling_speed * delta
		move_and_slide()
	else:
		self.rotation_degrees += death_rotation * delta
		self.position += death_direction * delta
		

func randomize_speed_and_rotation():
	if randi()%3 == 0:
		#pick slow mode, if you low rotation speed, you cant have high drill speed, otherwise you can't react
		drilling_speed = low_speeds[randi() % low_speeds.size()]
		rotation_speed = low_rotation_speeds[randi() % low_rotation_speeds.size()]
	else:
		#high rotation speed can be paired with both high and low speeds
		drilling_speed = speeds[randi() % speeds.size()]
		rotation_speed = high_rotation_speeds[randi() % high_rotation_speeds.size()]
	

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
	self.death_rotation = randf_range(-60, 60)
	self.death_direction = Vector2(randf_range(-8, 8), randf_range(-8, 8))
	self.alive = false
	$Collider.disabled = false
