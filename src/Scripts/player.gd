extends CharacterBody2D

@export var drilling_speed = 8000 #speed pixels/sec
var screen_size
@export var rotation_speed = 60.0
@export var maximum_angle = 80
var current_trail = null
var speed_factor = 1.0

var alive = true

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
