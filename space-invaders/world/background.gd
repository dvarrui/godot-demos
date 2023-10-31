extends Node2D

export var num_stars = 30
var Star = preload("res://world/star.tscn")
var size = Vector2(224, 256)

func _ready():	
	for _index in range(0, num_stars):
		var star = Star.instance()
		star.position.x = int(floor(rand_range(0, size.x)))
		star.position.y = int(floor(rand_range(0, size.y)))
		self.add_child(star)
