extends Node2D

var selected_card = null

func update_gout_counter(value):
	for c in get_children():
		c.update_gout_counter(value)

func select_card(card_name):
	selected_card = card_name
	for c in get_children():
		if c.card_name != card_name:
			c.set_selected(false)
