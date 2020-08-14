extends Node2D

const SPEED = 300
var id = 0 

func init(p_id):
	id = p_id
	name = str(id)
	$sprite/label.text = str(id)

func _process(delta):
	var dir = Vector2.ZERO
	if Input.is_action_pressed("player_letf"):
		dir += Vector2(-1, 0)
	if Input.is_action_pressed("player_right"):
		dir += Vector2(1, 0)
	if Input.is_action_pressed("player_up"):
		dir += Vector2(0, -1)
	if Input.is_action_pressed("player_down"):
		dir += Vector2(0, 1)
		
	var motion = dir * SPEED * delta
	translate(motion)
	rpc_id(1, "update_client_position", position)
