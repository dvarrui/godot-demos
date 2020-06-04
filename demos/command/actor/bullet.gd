extends Area2D

export var speed = 500
export var direction = Vector2()

func _process(delta):
	position = position + direction * speed * delta

func _on_bullet_body_entered(_body):
	self.queue_free()
