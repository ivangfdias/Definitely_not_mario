extends Node2D


export (Resource) var type
var inimigo
func _ready():
	
	$AnimatedSprite.visible = false
	inimigo = type.instance()
	add_child(inimigo)
	inimigo = get_child(1)
	pass # Replace with function body.
