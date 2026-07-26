extends Label

var timer: Timer
@export var level_select_path: String
@export var win_path: String

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = int(text)
	add_child(timer)
	timer.start()

func _process(_delta: float) -> void:
	text = str(roundi(timer.time_left))
	if int(text) <= 0:
		GlobalVars.level += 1
		get_tree().change_scene_to_file(win_path if GlobalVars.level > 5 else level_select_path)
