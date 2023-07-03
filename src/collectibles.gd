extends Area2D
signal collected

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var texture_size = $GoldenBomb.sprite_frames.get_frame_texture("default",0).get_size()
	$CollisionShape2D.shape = CircleShape2D.new()
	$CollisionShape2D.shape.radius = texture_size.x / 2
	$GoldenBomb.play()


func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("collected")
		hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

