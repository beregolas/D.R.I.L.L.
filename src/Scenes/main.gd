extends Node

var rock_scene = preload("res://Scenes/rock.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 5:
		var instance = rock_scene.instantiate()
		instance.position = Vector2(200.0 + 10*i , 200.0 + 100*i)
		self.add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
