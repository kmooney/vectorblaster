extends MeshInstance3D

var throttle: float = 10.0
var thrust_power: float = 100.0
var brake_power: float = 200.0
var velocity: Vector3 = Vector3.ZERO
var acc: float = 0.0
var rotation_speed: float = 5.0

@onready var weapon = $Weapon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:

	var turn_input = Input.get_axis("turn_left", "turn_right")
	rotate_y(-turn_input * rotation_speed * delta)
	
	var thrust_input = 0
	if Input.is_action_pressed("thrust"):
		thrust_input = thrust_power

	if Input.is_action_pressed("brake"):
		thrust_input = -brake_power
		
	if Input.is_action_pressed("fire"):
		weapon.fire()

	if thrust_input != 0:
		velocity += transform.basis.z * thrust_input  * delta

	position += velocity * delta
	
	velocity = velocity.lerp(Vector3.ZERO, 0.001)
	
	
	
