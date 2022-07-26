extends Node2D

export (int) var moveSpeed = 200
export var gravity = 32
export var jumpforce = 500

# var Kinematic = null; # Not needed if using  '$'

func _ready():
	#Kinematic = get_child(0) # Not needed if using '$'
	pass
	



func _process(delta):
	# Make variables modifiable from external scenes
	$Kinematic.gravity = gravity
	$Kinematic.moveSpeed = moveSpeed
	$Kinematic.jumpforce = jumpforce
