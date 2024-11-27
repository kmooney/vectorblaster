extends Node3D
class_name Weapon

signal weapon_fired(projectile: Node3D)

@export var fire_rate: float = 2.0
@export var projectile_scene: PackedScene
@export var muzzle_velocity: float = 20.0

var _time_since_last_shot: float = 0.0
var can_fire: bool  = true

func get_parent_velocity() -> Vector3:
	if get_parent() and get_parent().get("velocity") != null:
		return get_parent().velocity
	return Vector3.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not can_fire:
		_time_since_last_shot += delta
		if _time_since_last_shot >= 1.0 / fire_rate:
			can_fire = true

func fire() -> void:
	if not can_fire or not projectile_scene:
		return
	
	var projectile = projectile_scene.instantiate() as Node3D
	if not projectile:
		return
	
	projectile.global_transform = global_transform
	
	get_tree().root.add_child(projectile)
	if projectile.has_method("set_velocity"):
		var parent_velocity = get_parent_velocity()
		var projectile_velocity = global_transform.basis.z * muzzle_velocity 
		projectile.set_velocity(parent_velocity + projectile_velocity)
	
	weapon_fired.emit(projectile)
	can_fire = false
	_time_since_last_shot = 0.0
