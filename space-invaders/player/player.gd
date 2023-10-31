extends KinematicBody2D

enum State {
  ALIVE,
  DESTROYED,
}

var Laser = preload("res://player/laser.tscn")

onready var anim = $anim 
onready var laser_point = $laser_point
onready var timer_shot = $timer_shot

var dir = Vector2.ZERO
var speed = 200
var can_shot = true
var state = State.ALIVE
var min_x = 14
var max_x = 210
signal player_destroyed

func _ready():
	anim.play("alive")
	# alien.connect("alien_destroyed", self, "remove_alien")
	# warning-ignore:return_value_discarded
	self.connect("player_destroyed", get_parent(), "player_destroyed")

func _physics_process(_delta):
	if state == State.DESTROYED:
		return
	dir = Vector2.ZERO
	if Input.is_action_pressed("player_right") and position.x < max_x:
		dir.x += speed
	if Input.is_action_pressed("player_left") and position.x > min_x:
		dir.x -= speed
	if Input.is_action_just_pressed("player_fire") and can_shot == true:
		shot()

	# warning-ignore:return_value_discarded
	move_and_slide(dir)
	
func _on_shot_timer_timeout():
	can_shot = true

func destroy():
	if state != State.ALIVE:
		return
	state = State.DESTROYED
	timer_shot.stop()
	emit_signal("player_destroyed")
	anim.play("destroyed")

func remove():
	if !self.is_queued_for_deletion():
		get_parent().remove_child(self)
		queue_free()

func be_reborn():
	state = State.ALIVE
	anim.play("alive")
	can_shot = true
	timer_shot.start()
	show()

func shot():
	if state != State.ALIVE:
		return
	var laser = Laser.instance()
	laser.global_position = laser_point.global_position
	self.get_parent().add_child(laser)
	can_shot = false
	timer_shot.start()
