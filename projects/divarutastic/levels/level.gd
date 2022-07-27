extends Node2D

export var room_n = ""
export var room_s = ""
export var room_e = ""
export var room_w = ""

func _ready():
	get_node("effects/music").playing = true
	update_keys(0)
	pass

func _process(delta):
	if Input.is_action_just_pressed("game_menu"):
		get_tree().change_scene("res://levels/menu.tscn")

func update_keys(value):
	MyConfig.keys = MyConfig.keys + value
	$effects/keys.text = "Keys: " + str(MyConfig.keys)
	
func change_level(dir):
	if dir == "menu":
		get_tree().change_scene("res://levels/menu.tscn")
		pass

	var room_name = "res://levels/menu.tscn"
	if dir == "N":
		room_name = room_n
	elif dir == "S":
		room_name = room_s
	elif dir == "E":
		room_name = room_e
	elif dir == "W":
		room_name = room_w
		
	if room_name.length() == 0:
		get_tree().change_scene("res://levels/menu.tscn")
	else:
		get_tree().change_scene("res://levels/"+room_name+".tscn")

