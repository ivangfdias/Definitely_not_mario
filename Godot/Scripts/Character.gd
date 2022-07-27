extends Node2D

export (int) var moveSpeed = 200
export (float) var gravity = 32
export var jumpforce = 500

var Kinematic = null; # Not needed if using  '$'

var health = 0
func _ready():
	Kinematic = get_child(0) # Not needed if using '$'
	pass
	

func _on_damage():
	if (health > 0):
		health -= 1
	else:
		death()
		
func death():
	#deathLogic
	moveSpeed = 0
	jumpforce = 0
	$Kinematic/DamageCollision.disabled
	$Kinematic/KillCollision.disabled
	print('dead')
	

func _process(delta):
	# Make variables modifiable from external scenes
	$Kinematic.gravity = gravity
	$Kinematic.moveSpeed = moveSpeed
	$Kinematic.jumpforce = jumpforce
	

