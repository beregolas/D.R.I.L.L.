extends RigidBody2D

@export var drilling_speed = 400 #speed pixels/sec
var screen_size
@export var rotation_speed = 5.0
@export var maximum_angle = [-85, 85]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(linear_velocity)
	pass


func test_call(message):
	print(message)


