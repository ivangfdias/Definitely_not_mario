extends KinematicBody2D


export (int) var moveSpeed = 200
export (float) var gravity = 8
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
	
	# Jump treatment
	jump()
		
	
	if (abs(motion.x) > 0.25) or not is_on_floor(): # If moving
		print (motion.x)
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

# Sends damage to parent node
func damage():
	emit_signal('damage')

# Variable jump height!
func jump():
	if is_on_floor() && Input.is_action_just_pressed("ui_up"): # Press up:
			#JumpSound.play() # Play a cool sound
			motion.y = -jumpforce # And propel upwards
			
	motion.y += gravity # Fall
	if motion.y > 0:
		motion += Vector2.UP * (-9.81) * 2.5 # Fall is faster than jump
	elif motion.y < 0 && Input.is_action_just_released("up"): #Player is jumping 
		motion += Vector2.UP * (-9.81) * (15) #Jump Height depends on how long you will hold key	
	
func _physics_process(delta):
	get_input()
	
	
	
	motion = move_and_slide(motion, Vector2.UP)
	parseCollision()
