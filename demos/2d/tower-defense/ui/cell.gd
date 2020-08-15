extends Sprite

var id = "cell1x1"
var pos = Vector2.ZERO 
var content = null 

func _ready():
	id = name
	pass # Replace with function body.

# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_area_input_event(viewport, event, shape_idx):
	# Notify grandpa
	var grandpa = get_parent().get_parent()
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_LEFT:
			grandpa.cell_notification(id, global_position)
			content = grandpa.selected_card
			visible = false
			get_coord()

func get_coord():
	var a = id.split("x")
	var coord = Vector2(int(a[0]), int(a[1])) 
	print( coord )
	
