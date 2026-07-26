extends Node2D

@export var list: VBoxContainer
@export var game_path: String

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	activate_modifier(0)
	
	if not GlobalVars.just_died:
		GlobalVars.modifiers.clear()
	
	var new_children: Array[Label] = []
	
	new_children.append(Label.new())
	new_children.append(Label.new())
	new_children[0].text = 'Level ' + str(GlobalVars.level)
	new_children[1].text = 'Platform size: ' + str(6-GlobalVars.level)
	
	if GlobalVars.level > 1:
		new_children.append(Label.new())
		new_children[2].text = 'BUT'
	for i in range(GlobalVars.level-1):
		var mod = randi_range(1,5)
		while mod in GlobalVars.modifiers:
			mod = randi_range(1,5)
		activate_modifier(mod)
		GlobalVars.modifiers.append(mod)
		
		new_children.append(Label.new())
		new_children[i+3].text = get_mod_text(mod)
	
	if GlobalVars.just_died:
		new_children.insert(0, Label.new())
		new_children[0].text = 'Try again!'
		GlobalVars.just_died = false
	
	for child in new_children:
		child.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		var timer = Timer.new()
		timer.wait_time = 0.5
		add_child(timer)
		timer.start()
		await timer.timeout
		list.add_child(child)
	
	var timer2 = Timer.new()
	timer2.wait_time = 2
	add_child(timer2)
	timer2.start()
	await timer2.timeout
	
	get_tree().change_scene_to_file(game_path)

func get_mod_text(modifier: int) -> String:
	match modifier:
		1:
			return 'You are smol'
		2:
			return 'It\'s raining squares!'
		3:
			return '1.25x speed'
		4:
			return 'Bouncy ball'
		5:
			return 'Laser attacks!!!'
		#6:
			#return 'Maze mode (the goal is now to fall!!)'
	return 'ERROR'

## Put in modifier 0 to reset all
func activate_modifier(modifier: int) -> void:
	match modifier:
		0:
			GlobalVars.ball_size = 1
			GlobalVars.raining_squares = false
			GlobalVars.speed = 1
			Engine.time_scale = 1
			GlobalVars.bouncy_ball = false
			GlobalVars.laser_attack = false
		1:
			GlobalVars.ball_size = 0.5
		2:
			GlobalVars.raining_squares = true
		3:
			GlobalVars.speed = 1.25
		4:
			GlobalVars.bouncy_ball = true
		5:
			GlobalVars.laser_attack = true
