extends RigidBody2D

export var speed = 500

func run(pos, dir):
	self.position = pos
	self.apply_impulse(Vector2(0,0), dir * speed)

