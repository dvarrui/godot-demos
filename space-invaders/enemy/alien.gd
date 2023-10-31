extends KinematicBody2D

enum State {
	ALIVE,
	DESTROYED
}

export var step = 7
onready var anim = $anim
onready var bullet_point = $bullet_point
onready var timer_move = $timer_move

var origin = 0
var max_desp = 20
var dir = -1
var Bullet = preload("res://enemy/bullet.tscn")
var state = State.ALIVE
signal alien_destroyed

func _ready():
	timer_move.start()
	origin = self.position.x

func _on_timer_move_timeout():
	if state == State.ALIVE:
		position.x += dir * step
		if position.x > (origin + max_desp) or position.x < (origin - max_desp):
			dir *= -1

func destroy():
	if state == State.DESTROYED:
		return
	state = State.DESTROYED
	timer_move.stop()
	emit_signal("alien_destroyed", self)
	anim.play("destroyed")

func remove():
	if !self.is_queued_for_deletion():
		get_parent().remove_child(self)
		queue_free()

func shot():
	if state == State.ALIVE:
		var bullet = Bullet.instance()
		bullet.global_position = bullet_point.global_position
		self.get_parent().add_child(bullet)
