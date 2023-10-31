extends Node2D

export var row_number = 4
export var col_number = 8
export var shot_interval = 3
onready var shot_timer = $timer_shot
var Alien = preload("res://enemy/alien.tscn")
var aliens = []
var desp = Vector2(40, 40)
signal aliens_down

func _ready():
	# warning-ignore:return_value_discarded
	self.connect("aliens_down", self.get_parent(), "add_score_inc")
	# Creating a group of aliens
	for row in range(row_number):
		aliens.append([])
		for col in range(col_number):
			var alien = Alien.instance()
			alien.global_position = Vector2(desp.x + col * 20, desp.y + row * 20)
			self.add_child(alien)
			alien.connect("alien_destroyed", self, "remove_alien")
			alien.connect("alien_destroyed", self.get_parent(), "add_score")
			aliens[row].append(alien)

func remove_alien(obj):
	for list in aliens:
		for i in range(len(list) - 1):
			if obj == list[i]:
				list.remove(i)

func _on_timer_down_timeout():
	emit_signal("aliens_down")
	for list in aliens:
		for alien in list:
			if is_instance_valid(alien) and !alien.is_queued_for_deletion():
				alien.position.y += 10

func _on_timer_shot_timeout():
	var aliens_alive = []
	for list in aliens:
		for alien in list:
			if is_instance_valid(alien) and !alien.is_queued_for_deletion():
				aliens_alive.append(alien)
	if aliens_alive:
		var index = int(floor(rand_range(0, len(aliens_alive) - 1)))
		aliens_alive[index].shot()
		shot_timer.wait_time = rand_range(0, shot_interval)

