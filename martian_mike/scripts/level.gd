extends Node2D

@onready var start = $Start
@onready var player = $Player


# Called when the node enters the scene tree for the first time.
func _ready():
	player.global_position = start.get_spawn_position()
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.connect("touched_player", _on_trap_touched_player)

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
