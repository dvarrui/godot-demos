extends Node2D

export var required_gouts = 4
export var card_name = "shooter"
var active = false
var selected = true

func _ready():
	$sprite.modulate = Color(0.3,0.3,0.3,1)
	var filename = "res://assets/ui/cards/card_" + card_name + ".png"
	print_debug(filename)
	$sprite.texture = load(filename)

func update_gout_counter(value):
	if value >= required_gouts:
		$sprite.modulate = Color(1,1,1,1)

# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_card_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_LEFT and not selected:
			set_selected(true)
		if event.button_index == BUTTON_RIGHT and selected:
			set_selected(false)

func set_selected(value):
	if value:
		selected = true
		get_parent().select_card(card_name)
	else:
		selected = false
	$selected.visible = selected
