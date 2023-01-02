extends Node2D

var state = null

func _ready():
	change_to("move")

func change_to(statename):
	if state != null:
		state.exit()
	state = get_node("states/move")
	state.enter(self)
	
func _physics_process(delta):
	var new_state = null
	if state.has_method("process"):
		new_state = state.process(delta)
	
	self.z_index = position.y
