extends Node2D

export var card_name = "shooter"
var active = false  # true => User may select it
var selected = false # true => User select this card  
var data = {
	"shooter" : { "price":4},
	"katapult" : { "price":5}
}

func _ready():
	$sprite.modulate = Color(0.3,0.3,0.3,1)
	var filename = "res://assets/ui/cards/card_" + card_name + ".png"
	$sprite.texture = load(filename)

func update_gout_counter(value):
	if value >= data[card_name]["price"]:
		active = true
		$sprite.modulate = Color(1,1,1,1)
	else:
		active = false
		set_selected(false)
		$sprite.modulate = Color(0.3,0.3,0.3,1)

# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_card_input_event(viewport, event, shape_idx):
	if not active:
		return
	var grandpa = get_parent().get_parent()
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_LEFT and not selected:
			set_selected(true)
			grandpa.select_card(card_name)
		if event.button_index == BUTTON_RIGHT and selected:
			set_selected(false)
			grandpa.select_card("none")

func set_selected(value):
	selected = value
	$selected.visible = selected
