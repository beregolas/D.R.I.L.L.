extends Node2D

const NUM_EXPLOSIONS = 7
var total_explosions = 20
var continiue_exploding:bool = true
var explosionSprites = []
func _ready():
	pass
func explode():
	print("exploding")
	# Load the explosion sprites
	for i in range(4):
		var explosionSprite = get_node("explosion"+str(i+1))
		explosionSprites.append(explosionSprite)
		add_child(explosionSprite)
	play_single_explosion()


func play_single_explosion():
	for i in range(20): 
		for explosionSprite in explosionSprites:
			var explosion_type = randi_range(0,4)		
			explosionSprite.play("explosion"+str(explosion_type))
		await get_tree().create_timer(0.4).timeout
			
func playExplosionLoop():
	for i in range(total_explosions):	
		for explosionSprite in explosionSprites:
			if explosionSprite == null:
				print("is null")
				continue
			var randomPosition = Vector2(randi_range(0, get_viewport().size.x), randi_range(0, get_viewport().size.y))
		
			explosionSprite.position = randomPosition
			explosionSprite.play("explosion") # Replace "animation_name" with the actual animation name
			await get_tree().create_timer(0.1).timeout
  
