extends Panel

func _on_button_pressed():
	# Reading command
	var command = get_node("textedit").text
	get_node("textedit").text = ""
	
	# Executing command
	print("[INFO] Executing: ", command)
	var output = []
	var exitcode = OS.execute(command, [], true, output)

	# Displaying command output	
	get_node("label").text += output[0]
	print(output)
