extends Node

@export var p1: Node2D
@export var p2: Node2D



func _process(delta):
	var pos_delta = p1.position.y - p2.position.y

	if pos_delta < -400:
		p2.position.y = p1.position.y + 400
	if pos_delta > 400:
		p2.position.y = p1.position.y - 400
