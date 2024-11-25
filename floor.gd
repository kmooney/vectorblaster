extends Node3D

var t: float = 0.0
var mesh_instance : MeshInstance3D

@export var rotation_factor : float = 0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mesh_instance = MeshInstance3D.new()
	add_child(mesh_instance)
	
	var mesh: ArrayMesh = ArrayMesh.new()
	var vertices: PackedVector3Array = PackedVector3Array()
	var normals: PackedVector3Array = PackedVector3Array()
	var lines: PackedVector4Array = PackedVector4Array()
	var size: float = 20.0
	
	for i in range(8):
		var angle: float = i * PI / 4
		var x: float = size * cos(angle)
		var z: float = size * sin(angle)
		var anglep: float = ((i + 1) % 8) * PI / 4  # Fixed parentheses
		var xp: float = size * cos(anglep)
		var zp: float = size * sin(anglep)
		normals.append(Vector3(0,1,0))
		vertices.append(Vector3(x, 0, z))
		
		lines.append(Vector4(0,0,x,z))  # Spoke
		lines.append(Vector4(x, z, xp, zp))  # Edge
		print("Line %d: (%f,%f) to (%f,%f)" % [i, x, z, size*cos(anglep), size*sin(anglep)])
		
	vertices.append(Vector3(0,0,0))
	normals.append(Vector3(0,1,0))
	var center_idx: int = vertices.size() - 1
	
	var indices: PackedInt32Array = PackedInt32Array()
	for i in range(8):
		indices.append(center_idx)
		indices.append(i)
		indices.append((i + 1) % 8)
		
	var arrays: Array = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_INDEX] = indices
	
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	mesh_instance.mesh = mesh
	# Add this right before the end of _ready()
	
	var shader_material = ShaderMaterial.new()
	shader_material.set_shader_parameter("line_count", lines.size())
	shader_material.set_shader_parameter("lines", lines)
	shader_material.shader = preload("res://floorshader.gdshader")
	shader_material.set_shader_parameter("color", Color(0.3, 0.8, 1.0, 0.7))
	mesh_instance.material_override = shader_material
		
	


func _process(delta: float) -> void:
	rotation.y += delta * rotation_factor
	t += delta
	# Access shader parameters
	var material = mesh_instance.material_override
	material.set_shader_parameter("time", t)
