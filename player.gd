extends CharacterBody3D

var throttle: float = 10.0
var thrust_power: float = 100.0
var brake_power: float = 200.0
var acc: float = 0.0
var rotation_speed: float = 5.0
var max_velocity = 100.0

@export var color: Color = Color.RED

@onready var weapon = $Weapon
@onready var mesh_instance = $MeshInstance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if mesh_instance.material_override:
		mesh_instance.material_override.set_shader_parameter("color", color)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:

	var turn_input = Input.get_axis("turn_left", "turn_right")
	rotate_y(-turn_input * rotation_speed * delta)
	
	var thrust_input = 0
	if Input.is_action_pressed("thrust"):
		thrust_input = thrust_power

	if Input.is_action_pressed("brake"):
		velocity = velocity * 0.9
		
	if Input.is_action_pressed("fire"):
		weapon.fire()

	velocity += transform.basis.z * thrust_input  * delta
	velocity.limit_length(100.0)
	var old_v = velocity
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		var nrm = collision.get_normal()
		velocity = old_v.bounce(nrm) * 0.5
	
