
extends Sprite

var speed = 200
var move_timeout = 2
var move_interval = 0

func _ready():
	var screen = get_viewport_rect().size
	set_pos( screen/2)
	set_process(true)

func _process(delta):
	move_interval += delta
	if move_interval > move_timeout:
		move_interval = 0
		speed *= -1
	translate(Vector2(delta * speed, 0))
