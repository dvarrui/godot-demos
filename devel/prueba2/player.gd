extends Sprite

var speed = 250

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("player_left"):
		position.x = position.x - speed * delta
	if Input.is_action_pressed("player_right"):
		position.x = position.x + speed * delta
	if Input.is_action_pressed("player_up"):
		position.y = position.y - speed * delta
	if Input.is_action_pressed("player_down"):
		position.y = position.y + speed * delta
	
