extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var moveSpeed = 200
export (float) var gravity = 32
export (int) var jumpforce = 500
var motion = Vector2()
var sprite = null


func _ready():
	sprite = get_child(0)
	

# Based on Input
func get_input():
	
	
	if Input.is_action_pressed("ui_right"): # Press Right:
		motion.x = moveSpeed # move to the right
		$Sprite.flip_h = true # and look to the right
		
	elif Input.is_action_pressed("ui_left"): # Press Left
		motion.x = -moveSpeed # move to the left
		$Sprite.flip_h = false # and look to the left
	else: # Press nothing:
		motion.x = lerp(motion.x, 0, 0.25) # Smooth towards full stop
	
	if is_on_floor(): # If not aerial
		if Input.is_action_pressed("ui_up"): # Press up:
			#JumpSound.play() # Play a cool sound
			motion.y = -jumpforce # And propel upwards
			## !!TODO!! Make jump be of variable height as in the original SMB
	
	if motion.dot(motion) > 0.25: # If moving
		$Sprite.play('Walk') # Look like moving
	else:
		$Sprite.play('Normal') # Look like stop
	
	
	
func _physics_process(delta):
	get_input()
	motion.y += gravity + delta # Fall
	motion = move_and_slide(motion, Vector2.UP)
	
