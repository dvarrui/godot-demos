extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$sprite/sprite2.position = $sprite.transform.x * 100
	var t1 = $sprite.transform
	var t2 = $sprite/sprite2.transform
	print_debug("$sprite.position =>", $sprite.position)
	print_debug("$sprite.transform.xform() =>", t1.xform(Vector2(3,3)))
	print_debug("$sprite.transform.xform_inv =>", t1.xform_inv(Vector2.ZERO))
	print_debug("$sprite2.pos =>", t1.xform($sprite/sprite2.position))
	print_debug("$sprite2.global_pos =>", $sprite/sprite2.global_position)
	print_debug("$sprite2.global_pos_inv =>", t2.xform_inv(Vector2.ZERO))

func _process(delta):
	pass # Replace with function body.
