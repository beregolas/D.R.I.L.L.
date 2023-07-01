extends Node2D

const NUM_EXPLOSIONS = 4
var continiue_exploding:bool = true
var explosionSprites = []
var t 
func _ready():
	t =  get_node("Timer") # Save Timer as variable
	# Load the explosion sprites
	for i in range(NUM_EXPLOSIONS):
		var explosionSprite = load("res://explosion" + str(i + 1) + ".tscn").instance()
		explosionSprites.append(explosionSprite)
		add_child(explosionSprite)

func playExplosionLoop():
	while continiue_exploding:	
		for explosionSprite in explosionSprites:
			var randomPosition = Vector2(randi_range(0, get_viewport().size.x), randi_range(0, get_viewport().size.y))
			explosionSprite.position = randomPosition
			explosionSprite.animation.play("animation_name") # Replace "animation_name" with the actual animation name
			await get_tree().create_timer(0.3).timeout
  
	  
