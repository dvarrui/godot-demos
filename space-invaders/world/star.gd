extends Node2D

onready var anim = $anim
var types = 5

func _ready():
	var mode = int(floor(rand_range(1, types)))
	anim.play("idle" + str(mode))
