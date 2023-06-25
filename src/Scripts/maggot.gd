extends Area2D
signal collision

var speed = 50  # Geschwindigkeit der Bewegung
var direction = Vector2(1, 0)  # Richtung der Bewegung
var patrol_distance = 200
var distance_traveled = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _physics_process(delta):
	var velocity = direction * speed * delta
	position += velocity
	distance_traveled += abs(velocity.x)
	
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

	if distance_traveled >= patrol_distance or position.x <= 0 or position.x >= get_viewport().size.x:
		direction = -direction
		distance_traveled = 0


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
