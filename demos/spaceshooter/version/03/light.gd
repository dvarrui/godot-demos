extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("mover")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
