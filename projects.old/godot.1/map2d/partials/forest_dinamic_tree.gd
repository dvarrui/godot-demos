extends Area2D

var tree_class = load("res://actors/tree/tree.tscn")
var size = Vector2(100,100)
export var ext_items_count = 3 

func _ready():
	size = $shape.shape.get("extents")
	for i in range(ext_items_count):
		add_tree()

func add_tree():
	var t = tree_class.instance()
	t.position.x = rand_range( -size.x, size.x)
	t.position.y = rand_range( -size.y, size.y)
	t.ext_z = position.y + t.position.y
	add_child(t)
	
