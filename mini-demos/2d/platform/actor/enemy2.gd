extends Area2D

export var speed = 200
export var x_min = -100
export var x_max = 100
export var direction = 1
var origin = Vector2.ZERO

func _ready():
	origin = position
	$anim.play("default")
	$anim.playing = true

func _on_enemy2_body_entered(body):
	if body.is_in_group("player"):
		get_tree().quit()

func _process(delta):
	position.x += speed * direction * delta
	if position.x > (origin.x+x_max) or position.x < (origin.x+x_min):
		direction = direction * (-1)
