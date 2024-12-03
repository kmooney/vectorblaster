extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var song = load("res://songs/11-30-24-2.mp3")
	$AudioStreamPlayer.stream = song
	$AudioStreamPlayer.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
