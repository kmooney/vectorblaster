extends Node3D
class_name Projectile

@export var lifetime: float = 2.0
@export var damage: float = 10.0

var velocity: Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().create_timer(lifetime).timeout.connect(queue_free)

func _physics_process(delta: float) -> void:
	position += velocity * delta
	
func set_velocity(new_velocity: Vector3) -> void:
	velocity = new_velocity
