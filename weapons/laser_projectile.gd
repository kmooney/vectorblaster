extends Projectile
class_name LaserProjectile

var mesh: BoxMesh = BoxMesh.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
	# create a small box mesh
	var mesh_instance = MeshInstance3D.new()
	mesh.size = Vector3(0.1, 0.1, 2.0)
	mesh_instance.mesh = mesh
	
	var material = StandardMaterial3D.new()
	material.emission_enabled = true
	material.emission = Color(1, 0.2, 0.2)
	material.emission_energy_multiplier = 2.0
	mesh_instance.material_override = material
	
	add_child(mesh_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mesh.size.z += delta * 10.0
