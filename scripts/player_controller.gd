extends AnimatableBody3D

var _mouse_delta := Vector2.ZERO

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_delta += event.relative

func _physics_process(_delta: float) -> void:
	if _mouse_delta != Vector2.ZERO:
		var axis := Vector3(-_mouse_delta.y, 0, _mouse_delta.x).normalized().rotated(Vector3(0, 1, 0), deg_to_rad(215))
		rotate(axis, _mouse_delta.length() / 1000.0)
		_mouse_delta = Vector2.ZERO
