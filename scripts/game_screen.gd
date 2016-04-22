
extends Node2D

var num1
var num2

var correct_button = 0
var correct_answer = 0
var incorrect_answer = 0
var num_question = 0

var next_question = false

var haze = 1 # cambiar la opacidad del label

# Button wrong alternatives
var alt = [0, 0, 0]
var alt_index = 0

# Operators
const ADDITION = 0
const SUBTRACTION = 1
const MULTIPLICATION = 2
const DIVISION = 3

var operator_state

func _process(delta):
	if (next_question):
		reset_values()
		show_values()
		set_button_values()
		next_question = false
	
	if (incorrect_answer == 3):
		get_tree().change_scene("res://scenes/lost_screen.tscn")
	elif (num_question == 10):
		get_tree().change_scene("res://scenes/win_screen.tscn")
	
	haze -= 1 * delta
	get_node("reward").set_opacity(haze)

func _ready():
	randomize()
	next_question = true
	operator_state = Globals.get("OPERATOR_STATE")
	set_process(true)

func show_values():
	if (operator_state == ADDITION):
		get_node("show").set_text(str(num1) + " + " + str(num2))
	elif (operator_state == SUBTRACTION):
		get_node("show").set_text(str(num1) + " - " + str(num2))
	elif (operator_state == MULTIPLICATION):
		get_node("show").set_text(str(num1) + " * " + str(num2))
	elif (operator_state == DIVISION):
		get_node("show").set_text(str(num1) + " / " + str(num2))
	
func reset_values():
	num1 = int(rand_range(1, 10))
	num2 = int(rand_range(1, 10))
	
func get_result():
	if (operator_state == ADDITION):
		return num1 + num2
	elif (operator_state == SUBTRACTION):
		return num1 - num2
	elif (operator_state == MULTIPLICATION):
		return num1 * num2
	elif (operator_state == DIVISION):
		return num1 / num2
	
func set_button_values():
	correct_button = int(rand_range(1, 5))
	
	reset_alternatives()
	alternative_generator()
	
	value_button_generator(correct_button, 1)
	value_button_generator(correct_button, 2)
	value_button_generator(correct_button, 3)
	value_button_generator(correct_button, 4)
	
func value_button_generator(correct_button, num_button):
	if (correct_button == num_button):
		get_node("VBoxContainer/opt" + str(num_button)).set_text(str(get_result()))
	else:
		get_node("VBoxContainer/opt" + str(num_button)).set_text(str(int(alt[alt_index])))
		alt_index += 1

func alternative_generator():
	var num_nearness = 5

	while (alt[0] == 0 || alt[0] == get_result()):
		alt[0] = rand_range(get_result() - num_nearness, get_result() + num_nearness + 1)
		alt[0] = round(alt[0])
	while (alt[1] == 0 || alt[1] == get_result() || alt[1] == alt[0]):
		alt[1] = rand_range(get_result() - num_nearness, get_result() + num_nearness + 1)
		alt[1] = round(alt[1])
	while (alt[2] == 0 || alt[2] == get_result() || alt[2] == alt[1]):
		alt[2] = rand_range(get_result() - num_nearness, get_result() + num_nearness + 1)
		alt[2] = round(alt[2])

func reset_alternatives():
	alt = [0, 0, 0]
	alt_index = 0

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
