extends Area2D

enum State {
	ALIVE,
	DESTROYED,
}

export var speed = 150
var state = State.ALIVE

func _process(delta):
	if state == State.ALIVE:
		position.y += speed * delta

func _on_bullet_body_entered(body):
	if state != State.ALIVE:
		return
	if body.is_in_group("player"):
		if is_instance_valid(body) and !body.is_queued_for_deletion():
			body.destroy()
			destroy()

func _on_bullet_area_entered(area):
	if state != State.ALIVE:
		return
	if area.is_in_group("blocks"):
		if is_instance_valid(area) and !area.is_queued_for_deletion():
			area.destroy()
			destroy()

func destroy():
	if state == State.ALIVE:
		state = State.DESTROYED
		monitorable = false
		remove()
	
func remove():
	if !self.is_queued_for_deletion():
		var parent = get_parent()
		if is_instance_valid(parent) and !parent.is_queued_for_deletion():
			parent.remove_child(self)
		queue_free()


