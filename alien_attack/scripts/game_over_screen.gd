extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_score(new_score):
	$Panel/Score.text = "SCORE: " + str(new_score)

func _on_retry_button_pressed():
	get_tree().reload_current_scene()
