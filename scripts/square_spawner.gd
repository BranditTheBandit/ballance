extends Node3D

var squares_per_second: int

func _ready() -> void:
	squares_per_second = $"../Plate".scale.x * 10

var last_spawn: int
func _process(_delta: float) -> void:
	if not visible: return
	if not last_spawn or (Time.get_ticks_msec() - last_spawn)/1000. > 1./squares_per_second:
		var rb = RigidBody3D.new()
		add_child(rb)
		var mesh = MeshInstance3D.new()
		mesh.mesh = BoxMesh.new()
		rb.add_child(mesh)
		var collision = CollisionShape3D.new()
		collision.shape = BoxShape3D.new()
		rb.add_child(collision)
			
		rb.position = Vector3(rand_pos(), 0, rand_pos())
		rb.scale = Vector3(0.25,0.25,0.25)
		last_spawn = Time.get_ticks_msec()
		
func rand_pos() -> float:
	var plate_scale = $"../Plate".scale.x
	return randf_range(-plate_scale, plate_scale)
