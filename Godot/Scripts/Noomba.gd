extends KinematicBody2D


export (bool) var lookRight = false
export (int) var moveSpeed = 100
export (float) var gravity = 32
var motion = Vector2()
var isAlive = true

func _ready():
	pass # Replace with function body.

func parseCollision():
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		var collider = collision.collider
		var layer = collider.get_collision_layer()
		if (layer != 1):
			#logic
			pass
			#print(collider.name)
		elif (abs(collision.normal.y) == 0):
			lookRight = not lookRight

func setMovement(delta):
	motion.x = moveSpeed * (1 if lookRight else -1)
	$Sprite.flip_h = lookRight
	if (isAlive):
		$Sprite.play('walk')

func stomp():
	isAlive = false
	$Sprite.stop()
	$Sprite.play('dead')
	
	
	yield(get_tree().create_timer(0.1),'timeout')
	$Collision.disabled = true
	queue_free()
	
func getAlive():
	return isAlive

func _physics_process(delta):
	setMovement(delta)
	motion.y += gravity + delta
	motion = move_and_slide_with_snap(motion,Vector2.UP)
	parseCollision()

