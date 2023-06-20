extends Node2D

var garbage_images = [
	"res://Images/garbage/Icon2.png", 
	"res://Images/garbage/Icon3.png", 
	"res://Images/garbage/Icon4.png", 
	"res://Images/garbage/Icon8.png", 
	"res://Images/garbage/Icon46.png", 
	"res://Images/garbage/Icon47.png", 
	"res://Images/garbage/Icons_15.png", 
	"res://Images/garbage/Icons_28.png", 
	"res://Images/garbage/Icons_31.png"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var random_index = randi() % garbage_images.size()
	var selected_image = garbage_images[random_index]
	$Sprite.texture = load(selected_image)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
