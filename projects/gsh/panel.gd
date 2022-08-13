extends Panel

func _on_button_pressed():
	# Reading command
	var command = get_node("textedit").text
	get_node("textedit").text = ""
	
	# Executing command
	print("[INFO] Executing: ", command)
	var output = []
	# execute ( String path, PoolStringArray arguments, 
	#           bool blocking=true, Array output=[ ], 
	#           bool read_stderr=false, bool open_console=false )
	var exitcode = OS.execute(command, [], true, output)

	# Displaying command output	
	get_node("label").text += output[0]
	print(output)
