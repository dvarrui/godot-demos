extends Area2D

var origin = Vector2(0,0)
export var max_limit = Vector2(0,0)
export var min_limit = Vector2(0,0)
export var speed = Vector2(0,0)
export var face = 'snake'
export var state = 'run'
var current_state = ''

func _ready():
	get_node("sprite/" + face ).visible = true
	origin = position
	reset()

func reset():
	position = origin
	current_state = state
	
func _process(delta):
	update_position(delta)
	update_sprite()
	update_state()

func update_position(delta):
	if current_state == 'wait':
		return
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

func update_state():
	var dist = (origin - position).length()
	if dist < 1.1 and current_state == 'back':
		current_state = 'wait'
	
func player_is_near():
	current_state = 'run'

func player_is_far():
	if current_state == 'run':
		current_state = 'back'

func _on_enemy_body_entered(body):
	if body.name == 'player':
		body.reset()
