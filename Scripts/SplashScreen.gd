extends Control

export (PackedScene) var next_scene

onready var anim_player = get_node("AnimationPlayer")

var is_loading = true

func _ready():
	fade_in_out()

func fade_in_out():
	anim_player.play("Fade In Out")
	anim_player.connect("finished", self, "goto_next_scene")

func goto_next_scene():
	if(is_loading):
		var timer = Timer.new()
		add_child(timer)
		timer.set_wait_time(1) #seconds
		timer.set_one_shot(false)
		timer.connect("timeout", self, "next_scene")
		timer.start()
	else:
		next_scene()

func next_scene():
	if (!is_loading):
		print("Loading...")
		
		get_parent().add_child(next_scene.instance())
		queue_free()
		