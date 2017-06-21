extends Control

export (PackedScene) var next_scene
var next_scene_instance = null

#Loading Thread
onready var loading_thread = Thread.new()

func _ready():
	#Begin Loading Data
	loading_thread.start(self, "load_data")
	
	#Display Splash Screen
	splash_screen()

func splash_screen():
	print ("Load Splash Screen")
	
	#Create an instance
	next_scene_instance = next_scene.instance()
	
	#Add to scene
	add_child(next_scene_instance)

func load_data(data):
	#simulate data loading
	pass
	
	print("Done Loading Data!")
	next_scene_instance.is_loading = false