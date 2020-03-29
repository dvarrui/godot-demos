extends Area2D

export var bullet_duration = 10
export var bullet_speed = 20
var shooting = false
var resource = "res://actor/enemy/bullet.tscn"
var bullet_resource = null

func _ready():
	bullet_resource = load("res://actor/enemy/bullet.tscn")

func reset():
	shooting = false

func shoot():
	var bullet = bullet_resource.instance()
	bullet.set_duration(bullet_duration)
	bullet.set_speed(bullet_speed)
	self.add_child(bullet)

func _on_trigger_body_entered(body):
	if body.name == 'player':
		shoot()

func _on_trigger_body_exited(body):
	if body.name == 'player':
		reset()
