extends Sprite

func _ready():
	z_index = position.y

func _process(delta):
	z_index = position.y
