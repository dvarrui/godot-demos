extends Node2D

var speed = 100
var direction = Vector2(1,0)
var targets = []
var current_target = 0

func _ready():
	for i in get_children():
		if i is Position2D:
			targets.append(i.global_position)
	direction = (targets[0] - self.global_position).normalized()

func _process(delta):
	if self.global_position.distance_to(targets[current_target]) < 30:
		current_target += 1
		if current_target >= targets.size():
			current_target = 0
		direction = (targets[current_target] - self.global_position).normalized()
		
	var motion = direction * speed * delta
	position += motion
