extends StaticBody2D

# export (String) var sprite_name = "tree01"
export var ext_z = 0

func _physics_process(delta):
	z_index = ext_z
	$info.set_info(z_index)
