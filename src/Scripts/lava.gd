extends Area2D
signal collision


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("collision")
		hide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
