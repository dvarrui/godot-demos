extends KinematicBody2D

export var speed_x = 100
export var direction = 1
export var limit = Vector2.ZERO
var velocity = Vector2.ZERO
var origin = Vector2.ZERO

func _ready():
	origin = position
	
func _physics_process(delta):
	if position.x - origin.x > limit.y:
		direction = -1
	if position.x - origin.x < limit.x:
		direction = 1

	velocity.x = speed_x * direction
	move_and_slide(velocity, Vector2.UP)
