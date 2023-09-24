extends Node2D

@export var coin_scene : PackedScene
@export var powerup_scene : PackedScene
@export var playtime = 30
var level = 1
var score = 0
var time_left = 0
var screensize = Vector2.ZERO
var playing = false

func _ready():
	screensize = get_viewport().get_visible_rect().size
	$player.screensize = screensize
	$player.hide()

func _process(delta):
	if playing and get_tree().get_nodes_in_group("coins").size() == 0:
		level += 1
		time_left += 5
		spawn_coins()

func game_over():
	playing = false
	$game_timer.stop()
	get_tree().call_group("coins", "queue_free")
	$hud.show_game_over()
	$player.die()
	$sound/end.play()

func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$player.start()
	$player.show()
	$game_timer.start()
	spawn_coins()
	$hud.update_score(score)
	$hud.update_timer(time_left)

func spawn_coins():
	for i in level + 4:
		var c = coin_scene.instantiate()
		add_child(c)
		c.screensize = screensize
		c.position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))
	$sound/level.play()
	$powerup_timer.start()

func _on_game_timer_timeout():
	time_left -= 1
	$hud.update_timer(time_left)
	if time_left <= 0:
		game_over()

func _on_player_hurt():
	game_over()

func _on_hud_start_game():
	new_game()

func _on_player_pickup(type):
	match type:
		"coin":
			$sound/coin.play()
			score += 1
			$hud.update_score(score)
		"powerup":
			$sound/powerup.play()
			time_left += 5
			$hud.update_timer(time_left)


func _on_powerup_timer_timeout():
	var p = powerup_scene.instantiate()
	add_child(p)
	p.screensize = screensize
	p.position = Vector2(randi_range(0, screensize.x),
	randi_range(0, screensize.y))
