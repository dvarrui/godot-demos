extends Area2D

var screensize = Vector2.ZERO

func _ready():
	$timer.start(randf_range(3, 8))

func pickup():
	$shape.set_deferred("disabled", true)
	var tw = create_tween().set_parallel().set_trans(Tween.TRANS_QUAD)
	tw.tween_property(self, "scale", scale * 3, 0.3)
	tw.tween_property(self, "modulate:a", 0.0, 0.3)
	await tw.finished
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("obstacles"):
		position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))

func _on_timer_timeout():
	$anim.frame = 0
	$anim.play()

