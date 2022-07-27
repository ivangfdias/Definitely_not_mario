extends Camera2D


var player
func _ready():
	player = get_parent().get_child(1)


func _physics_process(delta):
	if player.getHealth() > 0:
		self.position.x = player.get_child(0).global_position.x
		self.position.y = player.get_child(0).global_position.y
		print('-----')
		print(self.position)
		print('//')
		print(player.position)
		print('+++++')
	align()
