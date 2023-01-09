extends Node

const DEBUG = false

var resources = {}
var objects = { ".":"none" }
var data = null
var index = -1
var offset_y = 0
var offset_y_step = 50
var offset_x_step = 50

func _ready():
	resources["rock32"] = preload("res://actor/rock/rock32.tscn")
	resources["rock64"] = preload("res://actor/rock/rock64.tscn")
	resources["satelite"] = preload("res://actor/enemy/satelite.tscn")
	resources["tie"] = preload("res://actor/enemy/tie.tscn")

func build_file_into_level(filename,level):
	load_filename(filename)
	for line in data:
		if line[0]=="info": 
			if DEBUG:
				print_debug("[INFO] "+ line[1])
		elif line[0]=="def":
			define_object_with(line[1],line[2],line[3])
		elif line[0]=="new":
			create_new_object(line[1], line[2], level)
		elif line[0]=="map":
			create_map_line(line[1], level)

func load_filename(filename):
	if DEBUG:
		print("[INFO] Loading "+filename)
	var file = File.new()
	var content = []
	file.open("res://" + filename, File.READ)
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
	if DEBUG:
		print("[INFO] def => <"+symbol+"> is a "+type+" with "+config)
	var obj = { "type":type, "config":config}
	objects[symbol]= obj

func create_new_object(type, config, level):
	if DEBUG:
		print("[INFO] new => "+type+" with "+config)
	var node = resources[type].instance()
	node.position.y = offset_y

	var params = {}
	for i in config.split(","):
		var j = i.split("=")
		if j[0].length() > 0:
			params[j[0]]=j[1]
	if params.has("x"):
		node.position.x = int(params["x"])
	if params.has("speed_x"):
		node.speed_x = int(params["speed_x"])
	if params.has("speed_y"):
		node.speed_y = int(params["speed_y"])
	if params.has("dir"):
		node.dir = int(params["dir"])
	level.get_node("world").add_child(node)

func create_map_line(line,level):
	if DEBUG:
		print("[INFO] map => "+ line)
	offset_y -= offset_y_step
	var offset_x = 0
	var i = 0
	while(i<line.length()):
		var k = line.substr(i,1)
		offset_x += offset_x_step
		if k != "." and objects.has(k):
			var type = objects[k]["type"]
			var config = objects[k]["config"]+",x="+str(offset_x)
			if DEBUG:
				print(type, config)
			create_new_object(type, config,level)
		i += 1

