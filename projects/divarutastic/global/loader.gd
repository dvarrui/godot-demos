extends Node

var resources = {}

func _ready():
	resources["spark"] = preload("res://environ/spark.tscn")

func create_new_object(data, level):
	var type = data["type"]
	var node = resources[type].instance()
	node.position.y = data["y"]
	node.position.x = data["x"]
	level.get_node("temp").add_child(node)
