extends Area2D

enum State {
	ALIVE,
	DAMAGED,
	DESTROYED,
}

onready var anim = $anim 
onready var shape = $shape
export var hits = 0
var state = State.ALIVE

func _ready():
	state = State.ALIVE
	anim.play("alive")

func destroy():
	if state == State.DESTROYED:
		monitorable=false
		return

	if is_instance_valid(self) and !is_queued_for_deletion():
		update()

func update():
	hits += 1
	if hits == 1:
		state = State.DAMAGED
		anim.play("damaged1")
	elif hits == 2:
		state = State.DESTROYED
		# shape.disabled = true # call_deferred()
		get_parent().remove_child(self)
		queue_free()
