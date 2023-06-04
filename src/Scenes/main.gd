extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_down"):
		# Wenn man hier 0 Übergibt fährt der Bohrer nur noch gerade, könnten wir also für die
		# Animationspause verwenden
		$RigidBodyPlayer.changeRotationSpeed(randf_range(0, PI * 2))
	pass
