extends Weapon
class_name BasicLaser


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_rate = 4.0
	muzzle_velocity = 30.0
	projectile_scene = preload("res://weapons/laser_projectile.tscn")
	
