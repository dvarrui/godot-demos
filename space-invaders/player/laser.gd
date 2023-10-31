extends Area2D

var speed = 200
var state = "alive"

func _process(delta):
	if state == "alive":
		position.y -= speed * delta

func _on_laser_body_entered(body):
	if state != "alive":
		return 
	if body.is_in_group("aliens"):
		state = "destroyed"
		if is_instance_valid(body) or !body.is_queued_for_deletion():
			body.destroy()
		# get_tree().queue_delete(self)
		# get_parent().remove_child(self)
		if !is_queued_for_deletion():
			queue_free()

func _on_laser_area_entered(area):
	if state != "alive":
		return 
	if area.is_in_group("blocks") or area.is_in_group("bullets"):
		state = "destroyed"
		if is_instance_valid(area) or !area.is_queued_for_deletion():
			area.destroy()
		if !is_queued_for_deletion():
			queue_free()
