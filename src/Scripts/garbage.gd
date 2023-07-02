extends Area2D
signal collision

enum SHAPES {CAPSULE, CIRCLE, RECT}

var garbage_images = [
	"res://Images/garbage/Icon1.png",
	"res://Images/garbage/Icon2.png", 
	"res://Images/garbage/Icon3.png", 
	"res://Images/garbage/Icon4.png",
	"res://Images/garbage/Icon6.png",
	"res://Images/garbage/Icon10.png",
	"res://Images/garbage/Icon23.png",
	"res://Images/garbage/Icon47.png", 
	"res://Images/garbage/Icons_15.png", 
	"res://Images/garbage/Icons_28.png"
]

var garbage_shapes = [
	SHAPES.CIRCLE,
	SHAPES.CAPSULE,
	SHAPES.CAPSULE,
	SHAPES.CAPSULE,
	SHAPES.CIRCLE,
	SHAPES.CIRCLE,
	SHAPES.CIRCLE,
	SHAPES.CAPSULE,
	SHAPES.CIRCLE,
	SHAPES.CAPSULE,
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var random_index = randi() % garbage_images.size()
	var selected_image = garbage_images[random_index]
	var selected_shape = garbage_shapes[random_index]
	$Sprite.texture = load(selected_image)
	var texture_size = $Sprite.texture.get_size()
	if selected_shape == SHAPES.CAPSULE:
		var shape = CapsuleShape2D.new()
		if texture_size.y < texture_size.x:
			$CollisionShape2D.rotate(deg_to_rad(90)) # Rotate the collision shape if the image is wider than it is tall
			shape.radius = texture_size.y / 2
			shape.height = texture_size.x
		else:
			shape.radius = texture_size.x / 2
			shape.height = texture_size.y
		$CollisionShape2D.shape = shape
	elif selected_shape == SHAPES.CIRCLE:
		$CollisionShape2D.shape = CircleShape2D.new()
		$CollisionShape2D.shape.radius = texture_size.x / 2
	elif selected_shape == SHAPES.RECT:
		$CollisionShape2D.shape = RectangleShape2D.new()
		$CollisionShape2D.shape.extents = texture_size / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("collision")
		hide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
