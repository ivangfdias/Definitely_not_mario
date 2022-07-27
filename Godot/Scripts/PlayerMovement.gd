extends KinematicBody2D


export (int) var moveSpeed = 200
export (float) var gravity = 32
export (int) var jumpforce = 500
var motion = Vector2()
var sprite = null

signal damage


func _ready():
	sprite = get_child(0)
	motion = move_and_slide(motion)

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
	
# Treats collision with objects, will deal with items later
func parseCollision():
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		var collider = collision.collider
		
		var layer = collider.get_collision_layer()
		#print(layer)
		
		if (layer == 4): # on Collide with enemy
			
			if ((collision.get_angle()) < deg2rad(45)):
				# this part should emit a signal
				# and let the parent node deal with it
				# (encapsulation)
				
				if (collider.getAlive()):
					motion.y -= jumpforce/2
					
					collider.stomp()
			else:
				damage() # Treats damage
				pass

func damage():
	emit_signal('damage')

	
	
func _physics_process(delta):
	get_input()
	motion.y += gravity + delta # Fall
	motion = move_and_slide(motion, Vector2.UP)
	parseCollision()
