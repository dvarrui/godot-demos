extends Node2D

var max_time = 5
var acc_time = 0
var gout_counter = 0
var data = {
	"shooter": { "sprite": "shootower", "price":4 },
	"katapult": { "sprite": "katapult", "price":5}
}

func _process(delta):
	update_progress_bar(delta)
	$cards.refresh_gout_counter(gout_counter)
	if Input.is_action_just_pressed("game_quit"):
		get_tree().quit()

func update_progress_bar(delta):
	acc_time += delta
	$progress_bar/bar.value = acc_time
	if acc_time > max_time:
		acc_time = 0
		gout_counter +=1
		$progress_bar/value.text = str(gout_counter)

func create_tower(tower_name, tower_pos):
	# Create new tower
	var tower = load("res://actor/" + tower_name + ".tscn").instance()
	tower.position = tower_pos
	$actors.add_child(tower)
	# Refresh gout counter
	gout_counter -= data[tower_name]["price"]
	$progress_bar/value.text = str(gout_counter)
	# Deselect card
	$cards.select_card("none")
	
