extends StaticBody2D

export var required_keys = 3

func _ready():
	pass # Replace with function body.

func open_with(keys):
	if keys == required_keys:
		get_node('sprite').visible = false 
		get_node("shape").disabled = true
		position = Vector2(0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
