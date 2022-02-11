extends Area2D

func _ready():
	$anim.play("sleep")

func _on_enemy1_body_entered(body):
	if body.is_in_group("player"):
		get_tree().quit()

func _on_detect_body_entered(body):
	if body.is_in_group("player"):
		$anim.play("idle")
	pass # Replace with function body.

func _on_detect_body_exited(body):
	if body.is_in_group("player"):
		$anim.play("sleep")
