extends Weapon
class_name BasicLaser

var which_offset = 0
var offsets =  [0.0, 2.0, 4.0, 6.0, 8.0, 10.0,
				12.0, 14.0, 16.0, 18.0, 20.0, 22.0]
@onready var audioplayer = $AudioStreamPlayer
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_rate = 4.0
	muzzle_velocity = 30.0
	projectile_scene = preload("res://weapons/laser_projectile.tscn")
	var laser_sounds = preload("res://sounds/11-30-24-3-lasers.mp3")
	$AudioStreamPlayer.stream = laser_sounds
	timer.timeout.connect(_on_timeout)

func _on_timeout():
	$AudioStreamPlayer.stop()

	
func fire() -> void:
	super()
	$AudioStreamPlayer.play(offsets[which_offset])
	timer.start(1.0)
	which_offset = (which_offset + 1) % 12
	
