extends Node2D

var speed = 300
var motion = Vector2.ZERO

func _ready():
	$label.text = self.name 

func _process(delta):
	# Is the master of the paddle.
	if is_network_master():
		var dir = Vector2.ZERO
		if Input.is_action_pressed("player_left"):
			dir += Vector2(-1, 0)
		if Input.is_action_pressed("player_right"):
			dir += Vector2(1, 0)
		if Input.is_action_pressed("player_up"):
			dir += Vector2(0, -1)
		if Input.is_action_pressed("player_down"):
			dir += Vector2(0, 1)
	
		motion = dir * speed * delta	
		translate(motion)
		# Using unreliable to make sure position is updated as fast
		# as possible, even if one of the calls is dropped.
		rpc_unreliable("set_pos", position)

# Synchronize position and speed to the other peers.
puppet func set_pos(p_pos):
	position = p_pos
