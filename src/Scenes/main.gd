extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_down"):
		$RigidBodyPlayer.changeRotationSpeed(randf_range(0, PI * 2))
		print("Rotation speed changed")
	pass
