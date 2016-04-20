
extends Node2D

var num1 = int(rand_range(1, 10))
var num2 = int(rand_range(1, 10))
var current_result = num1 + num2

func _process(delta):
	reset_values()
	show_values()
	set_button_values()

func _ready():
	set_process(true)

func show_values():
	get_node("show").set_text(str(num1) + " + " + str(num2))
	
func reset_values():
	randomize()
	num1 = int(rand_range(1, 10))
	num2 = int(rand_range(1, 10))
	
func get_result():
	return num1 + num2
	
func set_button_values():
	randomize()
	var correct_button = int(rand_range(1, 5))
	
	value_button_generator(correct_button, 1)
	value_button_generator(correct_button, 2)
	value_button_generator(correct_button, 3)
	value_button_generator(correct_button, 4)
	
func value_button_generator(correct_button, num_button):
	if (correct_button == num_button):
		get_node("VBoxContainer/opt" + str(num_button)).set_text(str(get_result()))
	else:
		get_node("VBoxContainer/opt" + str(num_button)).set_text(str(int(rand_range(1,10))))