extends Node2D

export var text = "Escribe tu texto aquí!"

func _ready():
	$detect/dialog.set_text(text)
	$detect/dialog.visible = false


func _on_detect_body_entered(body):
	if body.is_in_group("player"):
		$detect/dialog.visible = true


func _on_detect_body_exited(body):
	if body.is_in_group("player"):
		$detect/dialog.visible = false


func _on_timer_timeout():
	$detect/dialog.visible = false
