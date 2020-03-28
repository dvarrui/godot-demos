extends Area2D

var shooting = false
var resource = "res://actor/enemy/bullet.tscn"
var bullet_resource = null

func _ready():
	bullet_resource = load("res://actor/enemy/bullet.tscn")
	pass

func _on_trap_body_entered(body):
	if body.name == 'player':
		shoot()
		get_node("sprite").visible = true

func _on_trap_body_exited(body):
	if body.name == 'player':
		get_node("sprite").visible = false

func shoot():
	var bullet = bullet_resource.instance()
	self.add_child(bullet)
