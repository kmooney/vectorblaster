extends MeshInstance3D

var rotation_speed = 5.0
var move_speed = 20.0

var velocity: Vector3 = Vector.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Input.is_action_pressed("turn_left"):
		rotation.y += delta * rotation_speed

	if Input.is_action_pressed("turn_right"):
		rotation.y -= delta * rotation_speed
		
	if Input.is_action_pressed("thrust"):
		acc = 1.0
	else:
		acc = 0.0

	velocity += acc * delta
	position = transform.basis.z * velocity
