extends Area2D

export var speed = 1000

var origin = Vector2(0,0)
var shooting = false

func _ready():
	origin = position
	reset_bullet()

func reset_bullet():
	var bullet = get_node("bullet")
	bullet.position.y = origin.y - 4

func _process(delta):
	var bullet = get_node("bullet")
	if shooting:
		bullet.position.y += speed * delta

func _on_trap_body_entered(body):
	get_node("sprite").visible = true
	if body.name == 'player':
		shooting = true

func _on_trap_body_exited(body):
	get_node("sprite").visible =false
	if body.name == 'player':
		shooting = false

func _on_trap_area_exited(area):
	if area.name == 'bullet':
		reset_bullet()
