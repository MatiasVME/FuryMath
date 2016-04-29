
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	load_score()

func load_score():
	var data = File.new()
	data.open(global.score_path, data.READ)
	
	get_node("VBoxCont/score_add").set_text(data.get_line())
	get_node("VBoxCont/score_sub").set_text(data.get_line())
	get_node("VBoxCont/score_mult").set_text(data.get_line())
	get_node("VBoxCont/score_div").set_text(data.get_line())
	
	data.close()

func _on_back_pressed():
	get_tree().change_scene("res://scenes/menu_screen.tscn")
