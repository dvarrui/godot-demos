extends KinematicBody2D

# Node: player
export var speed_walk = 200
var map_height = null
var height = 1

const DEBUG = false
var state = null
var history = []

func _ready():
	set_height(1)
	# Set the initial state to the first child node
	state = get_node("states/move")
	_enter_state()

func get_cell_coord():
	return Vector2(int(position.x/48), int(position.y/48))

func get_cell_id(pos):
	return map_height.get_cell(pos.x, pos.y)

func set_height(value):
	height = value
	map_height = get_parent().get_node("heights/h" + str(height))
	if height == 1:
		collision_layer  = 1
		collision_mask = 1
	elif height == 2:
		collision_layer  = 2
		collision_mask = 2
	if height == 3:
		collision_layer  = 4
		collision_mask = 4

# Finity State Machine 
func change_to(new_state):
	history.append(state.name)
	state = get_node("states/"+new_state)
	_enter_state()

func back():
	if history.size() > 0:
		state = get_parent().get_node(history.pop_back())
		_enter_state()

func _enter_state():
	if DEBUG:
		print("Entering state: ", state.name)
	if state.name == "jump":
		state.dir = get_node("states/move").dir
	# Give the new state a reference to this state machine script
	state.enter(self)

# Route Game Loop function calls to
# current state handler method if it exists
#func _process(delta):
#	if state.has_method("process"):
#		state.process(delta)

func _physics_process(delta):
	var new_state = null
	if state.has_method("update"):
		new_state = state.update(delta)

#func _input(event):
#	if state.has_method("input"):
#		state.input(event)

#func _unhandled_input(event):
#	if state.has_method("unhandled_input"):
#		state.unhandled_input(event)

#func _unhandled_key_input(event):
#	if state.has_method("unhandled_key_input"):
#		state.unhandled_key_input(event)

#func _notification(what):
#	if state && state.has_method("notification"):
#		state.notification(what)
