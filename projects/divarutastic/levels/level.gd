extends Node2D

export var room_n = ""
export var room_s = ""
export var room_e = ""
export var room_w = ""

func _ready():
	#get_node("tilemap/black/color").visible = true
	get_node("effects/music").playing = true

func _process(delta):
	if Input.is_action_just_pressed("game_quit"):
		get_tree().quit()

func change_level(dir):
	print("[Level] Player exit ", dir)
	print("[Level] Player position ", get_node("player").position)
	var room_name = "QUIT"
	if dir == "N":
		room_name = room_n
	elif dir == "S":
		room_name = room_s
	elif dir == "E":
		room_name = room_e
	elif dir == "W":
		room_name = room_w
		
	if room_name.length() == 0:
		get_tree().quit()
	else:
		print("[Level] change scene: ", room_name)
		get_tree().change_scene("res://levels/"+room_name+".tscn")

