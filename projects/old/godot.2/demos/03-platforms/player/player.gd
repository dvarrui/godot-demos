
extends RigidBody2D

var ray = null
var speed = Vector2(120,500)
var state="stand"
var dir="left"
var anim_name= state+"_"+dir
var wait = true

func _ready():
	ray = get_node("ray")
	ray.add_exception(self)
	get_node("anim").play(anim_name)
	set_fixed_process(true)
	
func _fixed_process(delta):
	if ray.is_colliding():
		if Input.is_action_pressed("player_jump"):
			set_axis_velocity(Vector2(0, -speed.y))
			state="jump"
		else:
			state="stand"
	
	if Input.is_action_pressed("player_left"):
		set_axis_velocity(Vector2(-speed.x,0))
		state="move"
		dir="left"
	elif Input.is_action_pressed("player_right"):
		set_axis_velocity(Vector2(speed.x,0))
		state="move"
		dir="right"
	
	var s = state+"_"+dir
	if s!=anim_name:
		anim_name=s
		get_node("anim").play(anim_name)
		
	print("state => ",state,", dir =>",dir)

func _on_VisibilityNotifier2D_exit_screen():
	get_tree().quit()

