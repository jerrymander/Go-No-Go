extends Control

export (PackedScene) var splash_screen
export (PackedScene) var main_menu
export (PackedScene) var test_level
export (PackedScene) var hangar_scene
var next_scene = null

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
	next_scene = splash_screen.instance()
	
	#Add to scene
	add_child(next_scene)

func load_data(data):
	#simulate data loading
	pass
	
	print("Done Loading Data!")
	next_scene.is_loading = false