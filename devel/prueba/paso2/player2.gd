extends KinematicBody2D

export var speed = 12000
var bullet_resource

func _ready():
	$sprite.animation = "default"
	bullet_resource = load("res://paso2/bullet.tscn")

func _physics_process(delta):
	update_motion(delta)
	update_shot(delta)

func update_motion(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("player_up"):
		motion += Vector2(0, -1)
		$sprite.animation = "up"
	if Input.is_action_pressed("player_down"):
		motion += Vector2(0, 1)
		$sprite.animation = "down"
	if Input.is_action_pressed("player_left"):
		motion += Vector2(-1, 0)
		get_node("sprite").animation = "left"
	if Input.is_action_pressed("player_right"):
		motion += Vector2(1, 0)
		$sprite.animation = "right"
	if motion == Vector2(0,0):
		$sprite.animation = "default"

	motion = motion.normalized() * speed * delta
	move_and_slide(motion)

func update_shot(delta):
	if Input.is_action_just_pressed("player_shot"):
		var bullet = bullet_resource.instance()
		bullet.position.x = self.position.x + 32
		self.add_child(bullet)
		bullet.apply_impulse(Vector2(), Vector2(2500,-400))

