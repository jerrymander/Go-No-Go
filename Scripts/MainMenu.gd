extends Control

export (PackedScene) var next_scene

func _ready():
	set_process_input(true)

func _input(input):
	if (event.is_action_pressed("ui_accept")):
		print("Key hit")
		
		get_parent().add_child(next_scene.instance())
		queue_free()
	
	if (input.is_pressed(