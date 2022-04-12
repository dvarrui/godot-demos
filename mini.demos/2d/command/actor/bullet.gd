extends Area2D

export var speed = 500
export var direction = Vector2()

func _process(delta):
	position = position + direction * speed * delta

func _on_bullet_body_entered(body):
	if body.has_method("hurt"):
		body.hurt()
	self.queue_free()

func _on_visibility_screen_exited():
	self.queue_free()
