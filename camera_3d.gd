extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projection = Camera3D.PROJECTION_ORTHOGONAL
	get_tree().root.connect("size_changed", _on_viewport_size_changed)
	size = get_viewport().size.x / 20.0



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_viewport_size_changed():
	size = get_viewport().size.x / 20.0
