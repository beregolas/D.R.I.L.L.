extends Camera2D

@export var follow:Node2D

@export var preferred_distance = -1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance = follow.position - self.position
	# print(distance)
	if distance.y > preferred_distance: 
		self.position.y += distance.y;
	pass
