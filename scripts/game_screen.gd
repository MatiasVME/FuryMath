
extends Node2D

var num1 = int(rand_range(1, 10))
var num2 = int(rand_range(1, 10))
var correct_button = 0

var correct_answer = 0
var incorrect_answer = 0
var num_question = 0

var next_question = false
var haze = 1

func _process(delta):
	if (next_question):
		reset_values()
		show_values()
		set_button_values()
		next_question = false
	
	haze -= 1 * delta
	get_node("reward").set_opacity(haze)

func _ready():
	randomize()
	next_question = true
	set_process(true)

func show_values():
	get_node("show").set_text(str(num1) + " + " + str(num2))
	
func reset_values():
	num1 = int(rand_range(1, 10))
	num2 = int(rand_range(1, 10))
	
func get_result():
	return num1 + num2
	
func set_button_values():
	correct_button = int(rand_range(1, 5))
	
	value_button_generator(correct_button, 1)
	value_button_generator(correct_button, 2)
	value_button_generator(correct_button, 3)
	value_button_generator(correct_button, 4)
	
func value_button_generator(correct_button, num_button):
	if (correct_button == num_button):
		get_node("VBoxContainer/opt" + str(num_button)).set_text(str(get_result()))
	else:
		var value = rand_range(1,10)
		while (value == get_result()):
			value = rand_range(1,10)
		get_node("VBoxContainer/opt" + str(num_button)).set_text(str(int(value)))

func answer_button(num_button):
	if (correct_button == num_button):
		correct_answer += 1
		get_node("reward").set_text("Great!!")
	else:
		incorrect_answer += 1
		get_node("reward").set_text("Bad :(")
	
	num_question += 1
	next_question = true
	haze = 1

func _on_opt1_pressed():
	answer_button(1)

func _on_opt2_pressed():
	answer_button(2)

func _on_opt3_pressed():
	answer_button(3)

func _on_opt4_pressed():
	answer_button(4)
