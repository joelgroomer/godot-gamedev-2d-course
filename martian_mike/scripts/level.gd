extends Node2D

@export var next_level: PackedScene = null

@onready var start = $Start
@onready var exit = $Exit
@onready var death_zone = $Deathzone

var player = null


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	if player != null:
		player.global_position = start.get_spawn_position()
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.connect("touched_player", _on_trap_touched_player)
	
	if !exit.is_connected("body_entered", _on_exit_body_entered):
		exit.body_entered.connect(_on_exit_body_entered)
	if !death_zone.is_connected("body_entered", _on_deathzone_body_entered):
		death_zone.body_entered.connect(_on_deathzone_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_deathzone_body_entered(_body):
	reset_player()

func _on_trap_touched_player():
	reset_player()

func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position = start.get_spawn_position()

func _on_exit_body_entered(body):
	#print(next_level.resource_name)
	#print("helloooooo")
	if body is Player && next_level != null:
		exit.animate()
		player.active = false
		await get_tree().create_timer(1.5).timeout
		exit.queue_free()
		death_zone.queue_free()
		get_tree().change_scene_to_packed(next_level)
