
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/game_menu_screen.tscn")

func _on_CreditsButton_pressed():
	get_tree().change_scene("res://scenes/credits_screen.tscn")

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_StatsButton_pressed():
	get_tree().change_scene("res://scenes/stats_screen.tscn")
