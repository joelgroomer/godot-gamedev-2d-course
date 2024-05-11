extends Node2D

var hurt = preload("res://assets/audio/hurt.wav")
var jump = preload("res://assets/audio/jump.wav")

func play_sfx(sfx_name: String):
	var asp = AudioStreamPlayer.new()
	
	var stream
	if sfx_name == "hurt":
		stream = hurt
	elif sfx_name == "jump":
		stream = jump
	else:
		print("Invalid sfx name")
		return
	
	asp.stream = stream
	asp.name = "SFX"
	add_child(asp)
	asp.play()
	
	await asp.finished
	asp.queue_free()
