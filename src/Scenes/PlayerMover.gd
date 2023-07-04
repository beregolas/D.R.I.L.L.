extends Node

@export var p1: Node2D
@export var p2: Node2D



func _ready():
	if(self.name=="PlayerMover"):
		print("Move Player")
		get_parent().lives = 6
		get_parent().introLines.append("Second Player steers with Enter")
		
	if(self.name=="LifeSetter"):
		get_parent().lives = 100
		print("Life setter")

func _process(delta):
	if(self.name=="PlayerMover"):
		var pos_delta = p1.position.y - p2.position.y

		if pos_delta < -400:
			p2.position.y = p1.position.y + 400
		if pos_delta > 400:
			p2.position.y = p1.position.y - 400
