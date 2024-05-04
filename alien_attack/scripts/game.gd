extends Node2D

@onready var player = $Player
@onready var hud = $UI/HUD
@onready var ui = $UI
var game_over_scene = preload("res://scenes/game_over_screen.tscn")
var lives = 3
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hud.set_score_label(score)
	hud.set_lives_left(lives)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_death_zone_area_entered(area):
	area.die()

func _on_player_took_damage():
	lives -= 1
	print(lives)
	hud.set_lives_left(lives)
	if lives == 0:
		player.die()
		await get_tree().create_timer(1.5).timeout
		
		var game_over_instance = game_over_scene.instantiate()
		game_over_instance.set_score(score)
		ui.add_child(game_over_instance)

func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
