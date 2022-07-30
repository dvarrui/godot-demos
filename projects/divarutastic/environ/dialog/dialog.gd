extends Node2D

export var text = "Escribe tu texto!"

func _ready():
	self.set_text(text)

func set_text(msg):
	$lines.text = msg
