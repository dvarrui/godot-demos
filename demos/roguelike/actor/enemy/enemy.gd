extends Area2D

var origin = Vector2(0,0)
export var max_limit = Vector2(0,0)
export var min_limit = Vector2(0,0)
export var speed = Vector2(0,0)
export var face = 'snake'

func _ready():
	get_node("sprite/" + face ).visible = true
	origin = position

func _process(delta):
	update_position(delta)
	update_sprite()

func _on_enemy_area_entered(area):
	var parent = area.get_parent()
	if parent.name == 'player':
		parent.reset()

func update_position(delta):
	if speed.y != 0:
		position.y += speed.y * delta
		if position.y > (origin.y + max_limit.y):
			speed.y *= -1
		if position.y < (origin.y - min_limit.y):
			speed.y *= -1
	if speed.x != 0:
		position.x += speed.x * delta
		if position.x > (origin.x + max_limit.x):
			speed.x *= -1
		if position.x < (origin.x - min_limit.x):
			speed.x *= -1

func update_sprite():
	if speed.x > 0:
		self.get_node("sprite/" + face).flip_h=true
	else:
		self.get_node("sprite/" + face).flip_h=false	
