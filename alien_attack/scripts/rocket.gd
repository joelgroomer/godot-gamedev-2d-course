extends Area2D

@export var speed = 400
@onready var visible_notifier = $VisibleNotifier

func _ready():
	visible_notifier.connect("screen_exited", _on_screen_exited)

func _physics_process(delta):
	global_position.x += speed * delta

func _on_screen_exited():
	queue_free()	# deletes the rocket node as it leaves the screen

func _on_area_entered(area):
	queue_free()
	area.die()
