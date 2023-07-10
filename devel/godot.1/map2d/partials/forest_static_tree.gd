extends Node2D

func _ready():
	$tree.ext_z = position.y + $tree.position.y
	$tree2.ext_z = position.y + $tree2.position.y
	$tree3.ext_z = position.y + $tree3.position.y
	$tree4.ext_z = position.y + $tree4.position.y
	$tree5.ext_z = position.y + $tree5.position.y