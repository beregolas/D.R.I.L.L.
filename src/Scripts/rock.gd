extends Area2D
signal collision

enum SHAPES {CAPSULE, CIRCLE, RECT}

var rock_images = [
	"res://Images/rocks/rock1.png",
	"res://Images/rocks/rock1g.png",
	"res://Images/rocks/rock2.png",
	"res://Images/rocks/rock2g.png",
	"res://Images/rocks/rock3.png",
	"res://Images/rocks/rock3g.png",
	"res://Images/rocks/rock4.png",
	"res://Images/rocks/rock4g.png",
	"res://Images/rocks/rock5.png",
	"res://Images/rocks/rock5g.png",
	"res://Images/rocks/rock6.png",
	"res://Images/rocks/rock6g.png",
	"res://Images/rocks/rock7.png",
	"res://Images/rocks/rock7g.png",
	"res://Images/rocks/rock8.png",
	"res://Images/rocks/rock8g.png",
	"res://Images/rocks/rock9.png",
	"res://Images/rocks/rock9g.png",
	"res://Images/rocks/rock10.png",
	"res://Images/rocks/rock10g.png"
	]
	
var rock_shapes = [
	SHAPES.CAPSULE,
	SHAPES.CAPSULE,
	SHAPES.CIRCLE,
	SHAPES.CIRCLE,
	SHAPES.RECT,
	SHAPES.RECT,
	SHAPES.CAPSULE,
	SHAPES.CAPSULE,
	SHAPES.RECT,
	SHAPES.RECT,
	SHAPES.CIRCLE,
	SHAPES.CIRCLE,
	SHAPES.CAPSULE,
	SHAPES.CAPSULE,
	SHAPES.CIRCLE,
	SHAPES.CIRCLE,
	SHAPES.CAPSULE,
	SHAPES.CAPSULE,
	SHAPES.CAPSULE,
	SHAPES.CAPSULE,
]

func _ready():
	var random_index = randi() % rock_images.size()
	var selected_image = rock_images[random_index]
	var selected_shape = rock_shapes[random_index]
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
func _process(_delta):
	pass

func _init():
	pass
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Collision!")
		emit_signal("collision")
		hide()
		

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("removed rock")
	queue_free()
