extends HBoxContainer

export var time = 300
onready var time_label = $time/label

func _ready():
	update()

func _on_timer_panel_timeout():
	update()

func update():
	time -= 1
	time_label.text = str(time)
