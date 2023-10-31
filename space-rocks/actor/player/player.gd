extends RigidBody2D

enum {INIT, ALIVE, INVULNERABLE, DEAD}
var state = INIT

@export var engine_power = 500
@export var spin_power = 8000
var rotation_dir = 0
var screensize = Vector2.ZERO
var thrust = Vector2.ZERO

func _ready():
	screensize = get_viewport_rect().size
	change_state(ALIVE)

func change_state(new_state):
	match new_state:
		INIT:
			$shape.set_deferred("disabled", true)
		ALIVE:
			$shape.set_deferred("disabled", false)
		INVULNERABLE:
			$shape.set_deferred("disabled", true)
		DEAD:
			$shape.set_deferred("disabled", true)
	state = new_state

func _process(delta):
	get_input()

func get_input():
	thrust = Vector2.ZERO
	if state in [DEAD, INIT]:
		return
	if Input.is_action_pressed("thrust"):
		thrust = transform.x * engine_power
	rotation_dir = Input.get_axis("rotate_left", "rotate_right")

func _physics_process(delta):
	constant_force = thrust
	constant_torque = rotation_dir * spin_power

func _integrate_forces(physics_state):
	var xform = physics_state.transform
	xform.origin.x = wrapf(xform.origin.x, 0, screensize.x)
	xform.origin.y = wrapf(xform.origin.y, 0, screensize.y)
	physics_state.transform = xform
