extends Node2D

var selected_card = null
var data = {
	"shooter" : { "price":4},
	"katapult" : { "price":5}
}

func _ready():
	$cells.visible = false 
	pass
	
func refresh_gout_counter(value):
	for c in $list.get_children():
		c.update_gout_counter(value)

func select_card(card_name):
	selected_card = card_name
	$label.text = selected_card
	if selected_card == "none":
		$cells.visible = false
		return 
	$cells.visible = true
	for c in $list.get_children():
		if c.card_name != card_name:
			c.set_selected(false)

func cell_notification(id, pos):
	get_parent().create_tower(selected_card, pos)

# CELL COORDINATES
# cell1x1 -34, 70 
# cell1x2 -34, 134# cell1x3 -34, 198
# cell1x4 -34, 262
# cell1x4 -34, 325
