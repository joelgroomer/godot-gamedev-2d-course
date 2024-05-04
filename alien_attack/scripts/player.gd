extends CharacterBody2D

signal took_damage

var speed = 300.0
var rocket_scene = preload("res://scenes/rocket.tscn")
@onready var rocket_container = $RocketContainer		# An empty node used as a container to break the connection between player's position and rocket's (child) position
# @onready var rocket_container = get_node("RocketContainer") <-- longhand for $ shortcut

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

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
	
func shoot():
	var rocket_instance = rocket_scene.instantiate()
	rocket_container.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 75

func take_damage():
	emit_signal("took_damage")
	
func die():
	queue_free()
