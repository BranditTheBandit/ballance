extends Node3D

@export var interval: float = 2
@export var amount: int = 3
@export var ball: RigidBody3D
@export var level_select_path: String

var time_since_last: float
func _process(delta: float) -> void:
	if not visible: return
	
	time_since_last += delta
	if time_since_last > interval:
		time_since_last = 0
		for i in range(amount):
			var laser = Area3D.new()
			add_child(laser)
			
			var mesh = MeshInstance3D.new()
			mesh.mesh = CylinderMesh.new()
			mesh.mesh.height = 1000
			var material = StandardMaterial3D.new()
			material.albedo_color = Color(1, 0, 0, 0.5)
			material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
			mesh.material_override = material
			laser.add_child(mesh)
			
			var collision = CollisionShape3D.new()
			collision.shape = CylinderShape3D.new()
			collision.shape.height = 1000
			laser.add_child(collision)
			
			laser.position = Vector3(rand_pos(), 0, rand_pos())
		var timer = Timer.new()
		timer.wait_time = 1
		add_child(timer)
		timer.start()
		await timer.timeout
		for child in get_children():
			if child is Area3D:
				if ball in child.get_overlapping_bodies():
					GlobalVars.just_died = true
					get_tree().change_scene_to_file(level_select_path)
				else: child.queue_free()
func rand_pos() -> float:
	var plate_scale = $"../Plate".scale.x
	return randf_range(-plate_scale, plate_scale)
