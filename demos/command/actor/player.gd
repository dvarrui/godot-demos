extends KinematicBody2D

export var speed = 200 # Pixels/second
export var rot_speed = 5
var origin = Vector2(0,127) # Initial position
var bullet_res = load("res://actor/bullet.tscn") 

func _ready():
	origin = position

func _physics_process(delta):
	z_index = 20
	update_motion(delta)

func update_motion(delta):
	var motion = Vector2.ZERO
	var dir = Vector2(cos(rotation), sin(rotation))

	if Input.is_action_pressed("player_move"):
		motion = dir
	if Input.is_action_pressed("player_back"):
		motion = dir * -1
	if Input.is_action_pressed("player_turn_left"):
		rotate(-rot_speed * delta)
	if Input.is_action_pressed("player_turn_right"):
		rotate(rot_speed * delta)
	
	motion = motion.normalized() * speed
	move_and_slide(motion)

	if Input.is_action_just_pressed("player_shoot"):
		shot(dir)

func shot(dir):
	var bullet = bullet_res.instance()
	bullet.position = self.position + dir * 40
	bullet.direction = dir
	get_parent().add_child(bullet)

func _on_visibility_screen_exited():
	get_parent().exit_game()
