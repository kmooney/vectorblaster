extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Connected joypads: ", Input.get_connected_joypads())
	print("Joypad names: ", Input.get_joy_name(0))  # '0' is first controller


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
