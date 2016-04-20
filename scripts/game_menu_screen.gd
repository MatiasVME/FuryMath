
extends Node2D

var rotation = 0

func _process(delta):
	rotation += 0.01 * delta
	#get_node("suma").
	get_node("s_suma").rotate(rotation)

func _ready():
	set_process(true)


