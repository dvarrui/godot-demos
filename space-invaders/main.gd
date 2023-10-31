extends Node2D

var score = 0
var high = 0
var lives = 2
var score_inc = 10
var score_inc_inc = 5
onready var score_label = $panel/score/label
onready var high_label = $panel/high/label
onready var lives_label = $panel/lives/label
onready var timer_reborn = $panel/timer_reborn
onready var player = $player

func _ready():
	score_label.text = str(score)
	high_label.text = str(high)
	lives_label.text = str(lives)
	
func add_score(_alien):
	score += score_inc
	score_label.text = str(score)

func add_score_inc():
	score_inc += score_inc_inc

func player_destroyed():
	lives -=1
	lives_label.text = str(lives)
	if lives > 0:
		timer_reborn.start()
	else:
		player.remove()
		gameover()

func _on_timer_reborn_timeout():
	if is_instance_valid(player) and !player.is_queued_for_deletion():
		player.be_reborn()

func gameover():
	get_tree().change_scene("res://ui/gameover.tscn")
