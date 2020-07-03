extends Node2D

var max_time = 5
var acc_time = 0
var gout_counter = 0


func _process(delta):
	update_progress_bar(delta)
	$cards.update_gout_counter(gout_counter)
	if Input.is_action_just_pressed("game_quit"):
		get_tree().quit()

func update_progress_bar(delta):
	acc_time += delta
	$progress_bar/bar.value = acc_time
	if acc_time > max_time:
		acc_time = 0
		gout_counter +=1
		$progress_bar/value.text = str(gout_counter)

