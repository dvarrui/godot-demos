extends Node

var camera_speed = 20
var resources = {}

func _ready():
	resources["rock32"] = preload("res://environment/rock32.tscn")
	resources["rock64"] = preload("res://environment/rock64.tscn")

func load_filename(filename):
	var file = File.new()
	var content = []
	file.open("res://level/" + filename, File.READ)
	while not file.eof_reached():
		var line = file.get_line()
		var items = []
		if line.substr(0,1)=="#":
			items = [ "#", line.substr(1,-1)]
		else:
			items = line.split(":")
		content.append(items)
	file.close()
	return content

func build_node_with(type, config):
	var node = resources[type].instance()
	var params = {}
	for i in config.split(","):
		var j = i.split("=")
		params[j[0]]=j[1]
	if params["x"]:
		node.position.x = int(params["x"])
	return node
