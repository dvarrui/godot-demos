extends Sprite

export var id = "cell1x1"

func _ready():
	pass # Replace with function body.

# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_area_input_event(viewport, event, shape_idx):
	# Notify grandpa
	var grandpa = get_parent().get_parent()
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_LEFT:
			grandpa.cell_notification(id, global_position)
