
extends RigidBody2D

var SPEED = 200
var dying = false
var timeout = 1
var screen = Vector2(0,0)

func _ready():
	add_to_group("enemy")
	screen = get_viewport().get_rect().size
	set_fixed_process(true)
	apply_impulse(Vector2(0,0),Vector2(0,SPEED))

func _fixed_process(delta):
	if dying:
		timeout -= delta
		if timeout<1:
			set_opacity(timeout)
		if timeout<0:
			queue_free()
	if get_pos().y > screen.y:
		queue_free()

func explode():
	if dying == true:
		pass
	dying = true
	get_node("smoke").set_emitting(true)
	global.enemies_killed += 10
	shot(0.5)

func shot(prob):
	randomize()
	if randf() > prob:
		return
	var scene = preload("res://level2/laser2.tscn") 
	var node = scene.instance()
	var pos = get_pos()
	pos.y += 32
	node.set_pos(pos)
	var parent = get_tree().get_root().get_node("level2/bullets")
	parent.add_child(node)
