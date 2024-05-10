extends CharacterBody2D
class_name Player

@export var speed = 125
@export var jump_force = 200
@export var gravity = 400

@onready var animated_sprite = $AnimatedSprite2D

var active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500
	
	var direction = 0
	if active:
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump(jump_force)

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		direction = Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
		
	animated_sprite.flip_h = (direction == -1)
	move_and_slide()
	update_animations(direction)

func jump(force):
	velocity.y = -force
	
func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
