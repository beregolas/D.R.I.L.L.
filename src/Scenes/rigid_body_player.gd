extends RigidBody2D

@export var speed = 400 #speed pixels/sec
@export var rotation_speed = 1.5
var downwardSpeed = 50 #speed pixels/sec
var rotation_direction = 0

var screen_size

var debugging = false



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	velocity.y = downwardSpeed
	
	rotation_direction = Input.get_axis("move_left", "move_right") if debugging else 0
	
	#velocity.y += downwardSpeed # always moves down by at least downwardspeed pixels/second
	velocity += transform.y * speed
	if Input.is_action_pressed("TheOnlyAction") && rotation>-PI/2 || rotation>PI/2:
		rotation_direction += -0.5
	elif(rotation<PI/2):
		rotation_direction += 0.5

	rotation += rotation_direction * rotation_speed * delta
	position.x = clamp(position.x, 100, 3800)
	position.y = clamp(position.y, 0, 5800)

		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	
func changeRotationSpeed(newRotSpeed: float):
	rotation_speed = newRotSpeed
	

func explode():
	hide()
	$Camera2D.zoom.x = 0.1
	$Camera2D.zoom.y = 0.1
	
