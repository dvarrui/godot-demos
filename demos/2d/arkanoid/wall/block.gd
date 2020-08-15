extends StaticBody2D

export var type = "red"
var life = 1
var hits = 0

func _ready():
	if type == "red":
		life = 1
	if type == "green":
		life = 2
	$sprite.texture = load("res://wall/block_" + type + ".png")

func hit():
	hits +=1 
	if hits >= life:
		queue_free()
