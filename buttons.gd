extends CanvasLayer

var numbertest
var operator_array = []
var clear: bool = true
var test_array = [1,2,3]

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(test_array.back())
	#print(test_array)
	#print(test_array.back())
	#print(test_array.pop_back())
	#print(test_array.back())
	#print(test_array)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_priority(c):
	match c:
		"(",")":
			return 0
		"+", "-":
			return 1
		"/", "*":
			return 2
		_:
			return 999


func convert_to_postfix(infix: String):
	var operator_stack = []
	var postfix: String = ""
	var index: int = 0
	
	while infix.length() != index:
		var next_character = infix[index]
		if next_character.is_valid_int():
			postfix = postfix + next_character
			index += 1
			print("here 1")
		else:
			match next_character:
				"+","-","*","/":
					while !operator_stack.is_empty() && get_priority(next_character) <= get_priority(operator_stack.back()):
						postfix = postfix + operator_stack.back()
						operator_stack.pop_back()
						print("here 2")
					operator_stack.push_back(next_character)
					index += 1
					print("here 3")
					#break
				"(":
					operator_stack.push_back(next_character)
					index += 1
					#break
				")":
					var top_operator = operator_stack.pop_back()
					while top_operator != "(":
						postfix = postfix + top_operator
						top_operator = operator_stack.pop_back()
						index += 1
					#break
				_:
					index += 1
					print("here 4")
					#break
	while !operator_stack.is_empty():
		var top_operator = operator_stack.pop_back()
		postfix = postfix + top_operator
		print("here 5")
	return postfix

func evaluate_postfix(postfix: String):
	var value_stack = []
	var index: int = 0
	
	while postfix.length() != index:
		var next_character = postfix[index]
		if next_character.is_valid_int():
			value_stack.push_back(next_character)
			index += 1
		else:
			match next_character:
				"+":
					var operand_two = int(value_stack.pop_back())
					var operand_one = int(value_stack.pop_back())
					var result = operand_one + operand_two
					value_stack.push_back(str(result))
					index += 1
				"-":
					var operand_two = int(value_stack.pop_back())
					var operand_one = int(value_stack.pop_back())
					var result = operand_one - operand_two
					value_stack.push_back(str(result))
					index += 1
				"*":
					var operand_two = int(value_stack.pop_back())
					var operand_one = int(value_stack.pop_back())
					var result = operand_one * operand_two
					value_stack.push_back(str(result))
					index += 1
				"/":
					var operand_two = int(value_stack.pop_back())
					var operand_one = int(value_stack.pop_back())
					var result = operand_one / operand_two
					value_stack.push_back(str(result))
					index += 1
				_:
					index += 1
	return value_stack.back()



func process_numbers(number):
	if clear:
		clear = false
		$input.text = number
		print(number)
	else:
		$input.text = $input.get_text() + number
		$input.show()
		print(number)
	

func _on_number_1_pressed():
	process_numbers("1")
	operator_array.append(1)


func _on_number_2_pressed():
	process_numbers("2")
	operator_array.append(2)


func _on_equaloperator_pressed():
	#var temp1 = operator_array.pop_front()
	#var temp2 = operator_array.pop_front()
	#var temp3 = operator_array.pop_front()
	#if temp2 == "+":
		#print(temp1 + temp3)
	print($input.get_text())
	var printme = convert_to_postfix($input.get_text())
	print(printme)
	var answer = evaluate_postfix(printme)
	print(answer)
	$input.text = answer
	$input.show()


func _on_plusoperator_pressed():
	process_numbers("+")
	operator_array.append("+")


func _on_number_3_pressed():
	process_numbers("3")


func _on_number_4_pressed():
	process_numbers("4")


func _on_number_5_pressed():
	process_numbers("5")


func _on_number_6_pressed():
	process_numbers("6")


func _on_number_7_pressed():
	process_numbers("7")


func _on_number_8_pressed():
	process_numbers("8")


func _on_number_9_pressed():
	process_numbers("9")


func _on_minusoperator_pressed():
	process_numbers("-")


func _on_timesoperator_pressed():
	process_numbers("*")


func _on_divideoperator_pressed():
	process_numbers("/")


func _on_clear_pressed():
	$input.text = "0"
	$input.show()
	clear = true
