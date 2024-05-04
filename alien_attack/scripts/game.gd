extends Node2D

@onready var player = $Player
@onready var hud = $UI/HUD
var lives = 3
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hud.set_score_label(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_death_zone_area_entered(area):
	area.die()


func _on_player_took_damage():
	lives -= 1
	if lives == 0:
		print("Game over")
		player.die()
	else:
		print(lives)

func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
