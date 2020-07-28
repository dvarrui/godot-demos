extends Node

var resources = {}
var data = null
var index = -1
var offset_y = 0
var offset_y_step = 50

func _ready():
	resources["rock32"] = preload("res://world/rock32.tscn")
	resources["rock64"] = preload("res://world/rock64.tscn")
	resources["satelite"] = preload("res://actor/enemy/satelite.tscn")
	resources["tie"] = preload("res://actor/enemy/tie.tscn")

func build_file_into_level(filename,level):
	load_filename(filename)
	for line in data:
		if line[0]=="info": 
			print("[INFO] "+ line[1])
		elif line[0]=="def":
			define_object_with(line[1],line[2],line[3])
		elif line[0]=="map":
			print("[INFO] map => "+ line[1])
			offset_y -= offset_y_step
		elif line[0]=="new":
			print("[INFO] new => "+ line[1])
			var node = create_new_object_with(line[1], line[2])
			level.get_node("world").add_child(node)

func load_filename(filename):
	print("[INFO] Loading "+filename)
	var file = File.new()
	var content = []
	file.open("res://level/" + filename, File.READ)
	while not file.eof_reached():
		var line = file.get_line()
		var items = line.split(":")
		if items.size()>1:
			content.append(items)
	file.close()
	data = content.duplicate()
	data.invert()
	index = data.size()

func define_object_with(symbol, type, config):
	print("[INFO] def("+symbol+") => "+type+" with "+config)

func create_new_object_with(type, config):
	var node = resources[type].instance()
	node.position.y = offset_y

	var params = {}
	for i in config.split(","):
		var j = i.split("=")
		params[j[0]]=j[1]
	if params.has("x"):
		node.position.x = int(params["x"])
	if params.has("speed_x"):
		node.speed_x = int(params["speed_x"])
	if params.has("speed_y"):
		node.speed_y = int(params["speed_y"])
	if params.has("dir"):
		node.dir = int(params["dir"])
	return node
