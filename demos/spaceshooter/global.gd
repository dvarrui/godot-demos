extends Node

var camera_speed = 20
var resources = {}
var build_timeout = 1

func _ready():
	resources["rock32"] = preload("res://world/rock32.tscn")
	resources["rock64"] = preload("res://world/rock64.tscn")
	resources["satelite"] = preload("res://actor/enemy/satelite.tscn")
	resources["tie"] = preload("res://actor/enemy/tie.tscn")

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
	if params.has("x"):
		node.position.x = int(params["x"])
	if params.has("y"):
		node.position.y = int(params["y"])
	if params.has("speed_x"):
		node.speed_x = int(params["speed_x"])
	if params.has("speed_y"):
		node.speed_y = int(params["speed_y"])
	if params.has("dir"):
		node.dir = int(params["dir"])
	if params.has("next"):
		build_timeout = float(params["next"]) / camera_speed
	return node
