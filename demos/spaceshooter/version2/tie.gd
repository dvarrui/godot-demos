extends Area2D

export var speed = 300

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_tie_area_entered(area):
	if area.name == 'bullet_up':
		area.queue_free()
		#$particles.show_on_top
		queue_free()

