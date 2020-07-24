extends Node

var camera_speed = 20

func load_filename(filename):
	var file = File.new()
	var content = []
	file.open("res://level/" + filename, File.READ)
	while not file.eof_reached():
		content.append(file.get_line())
	file.close()
	return content
