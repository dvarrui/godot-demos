extends CanvasLayer

signal start_game

func update_score(value):
	$container/score.text = str(value)

func update_timer(value):
	$container/time.text = str(value)

func show_message(text):
	$message.text = text
	$message.show()
	$timer.start()

func _on_timer_timeout():
	$message.hide()

func _on_start_button_pressed():
	$start_button.hide()
	$message.hide()
	start_game.emit()

func show_game_over():
	show_message("Game Over")
	await $timer.timeout
	$start_button.show()
	$message.text = "Coin Dash!"
	$message.show()
