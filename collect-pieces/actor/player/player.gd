extends Area2D

@export var speed = 350
@onready var anim = $anim
var velocity = Vector2.ZERO
var screensize = Vector2(480, 700)

signal pickup
signal hurt

func _process(delta):
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += velocity * speed * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)

	if velocity.length() > 0:
		anim.animation = "run"
	else:
		anim.animation = "idle"
	if velocity.x != 0:
		anim.flip_h = velocity.x < 0

func start():
	set_process(true)
	position = screensize / 2
	anim.animation = "idle"

func die():
	anim.animation = "hurt"
	set_process(false)

func _on_area_entered(area):
	if area.is_in_group("coins"):
		area.pickup()
		pickup.emit("coin")
	if area.is_in_group("powerups"):
		area.pickup()
		pickup.emit("powerup")
	if area.is_in_group("obstacles"):
		hurt.emit()
		die()
