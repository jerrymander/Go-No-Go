extends Node

var next_scene = null

func _ready():
	set_process_input(true)

func _input(input):
	if (input.is_action_pressed("ui_accept")):
		next_scene = get_parent().test_level.instance()
		get_parent().add_child(next_scene)
		queue_free()
	
	if (input.is_action_pressed("ui_cancel")):
		next_scene = get_parent().main_menu.instance()
		get_parent().add_child(next_scene)
		queue_free()