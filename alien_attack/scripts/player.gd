extends CharacterBody2D


var speed = 300.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	velocity = Vector2(0,0)
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
		
	move_and_slide()
	
	# Clamping player's position inside the screen
	# 3 ways to do it
	var screen_size = get_viewport_rect().size
	
	# 1.
	#if global_position.x < 0:
		#global_position.x = 0
	#if global_position.x > screen_size.x:
		#global_position.x = screen_size.x
	#if global_position.y < 0:
		#global_position.y = 0
	#if global_position.y > screen_size.y:
		#global_position.y = screen_size.y
	
	# 2.
	#global_position.x = clampf(global_position.x, 0, screen_size.x)
	#global_position.y = clampf(global_position.y, 0, screen_size.y)
	
	# 3.
	global_position = global_position.clamp(Vector2(0,0), screen_size)
	
