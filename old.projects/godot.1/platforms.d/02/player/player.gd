extends RigidBody2D
# Set mode = Character

var siding_left = false
var jumping = false
var stopping_jump = false

var WALK_ACCEL = 800.0
var WALK_DEACCEL = 800.0
var WALK_MAX_VELOCITY = 200.0
var JUMP_VELOCITY = 460
var STOP_JUMP_FORCE = 900.0

func _integrate_forces(s):
	var lv = s.get_linear_velocity()
	var step = s.get_step()
	
	var new_siding_left = siding_left
	
	# Get the controls
	var move_left = Input.is_action_pressed("move_left")
	var move_right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_pressed("jump")
	
	# Process jump
	if jumping:
		if lv.y > 0:
			jumping = false
		elif not jump:
			stopping_jump = true
		
		if stopping_jump:
			lv.y += STOP_JUMP_FORCE * step
	
	# Process logic when character is on floor
	if lv.y == 0:
		if move_left and not move_right:
			if lv.x > -WALK_MAX_VELOCITY:
				lv.x -= WALK_ACCEL * step
		elif move_right and not move_left:
			if lv.x < WALK_MAX_VELOCITY:
				lv.x += WALK_ACCEL * step
		else:
			var xv = abs(lv.x)
			xv -= WALK_DEACCEL * step
			if xv < 0:
				xv = 0
			lv.x = sign(lv.x) * xv
		
	# Check jump
	if not jumping and jump:
		lv.y = -JUMP_VELOCITY
		jumping = true
		stopping_jump = false
		
	# Check siding
	if lv.x < 0 and move_left:
		$sprite.flip_h=true
	elif lv.x > 0 and move_right:
		$sprite.flip_h=false	

	# Finally, apply gravity and set back the linear velocity
	lv += s.get_total_gravity() * step
	s.set_linear_velocity(lv)
