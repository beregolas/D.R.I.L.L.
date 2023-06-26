extends Camera2D

@export var follow:Node2D

@export var preferred_distance = -1000

@export var camera_speed = 0.09

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var target_y = follow.position.y + preferred_distance
	position.y = lerp(position.y, target_y, camera_speed)
	pass
