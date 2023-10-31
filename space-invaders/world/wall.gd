extends Node2D

export var offset = Vector2.ZERO
var Block = preload("res://world/block2.tscn")

func _ready():
	var screen = Vector2(224,256)
	offset.x = 100
	offset.y = screen.y/2 + 70
	var block
		
	for i in range(10):
		block = Block.instance()
		block.global_position = Vector2(offset.x + i * 2, offset.y)
		add_child(block)
