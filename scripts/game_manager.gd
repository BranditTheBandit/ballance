extends Node3D

@export var level_select_path: String

var platform_size: int
var camera_dist: float

func _ready() -> void:
	platform_size = (6-GlobalVars.level)
	camera_dist = platform_size * 1.5

	$Plate.scale = Vector3(platform_size, platform_size * 0.4, platform_size)
	$Camera.position = Vector3(camera_dist, 0, camera_dist)
	
	$Ball.scale = Vector3(GlobalVars.ball_size, GlobalVars.ball_size, GlobalVars.ball_size)
	$SquareSpawner.visible = GlobalVars.raining_squares
	Engine.time_scale = GlobalVars.speed
	var ball_physics = PhysicsMaterial.new()
	ball_physics.bounce = 0.6 if GlobalVars.bouncy_ball else 0.
	$Ball.physics_material_override = ball_physics
	$LaserAttacker.visible = GlobalVars.laser_attack
	
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(_delta) -> void:
	# hardcoded death "plane"
	if $Ball.position.y < -platform_size or $Ball.position.x < -camera_dist or $Ball.position.x > camera_dist or $Ball.position.z < -camera_dist or $Ball.position.z > camera_dist:
		GlobalVars.just_died = true
		get_tree().change_scene_to_file(level_select_path)
