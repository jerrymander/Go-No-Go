extends Node

onready var SHIP_CORES = preload("res://Scenes/Ship Parts/Ship Core Library.tscn").instance()
onready var PLAYER = preload("res://Scenes/Player.tscn")
onready var SHIP_PREVIEW = get_node("ShipPreview")

var NEXT_SCENE = null
var CORE_NODE = null

func _ready():
	set_process_input(true)

func _input(input):
#	if (input.is_action_pressed("ui_accept")):
#		NEXT_SCENE = get_parent().test_level.instance()
#		get_parent().add_child(NEXT_SCENE)
#		queue_free()
	
	if (input.is_action_pressed("ui_cancel")):
		NEXT_SCENE = get_parent().main_menu.instance()
		get_parent().add_child(NEXT_SCENE)
		queue_free()

func _on_Ship1_released():
	print("The proven core. You know what you're getting with this one.")
	CORE_NODE = SHIP_CORES.generate_core(2)

func _on_Ship2_released():
	print("Newer. Better. Faster. Stronger. Or so the saying goes.")
	CORE_NODE = SHIP_CORES.generate_core(3)

func _on_TestShip_released():
	if (CORE_NODE == null):
		print("ERROR: No core selected.")
	else:
		NEXT_SCENE = get_parent().test_level.instance()
		get_parent().add_child(NEXT_SCENE)
		CORE_NODE.set_pos(Vector2(512,288))
		get_parent().add_child(CORE_NODE)
		queue_free()
	

func _on_Back_released():
	NEXT_SCENE = get_parent().main_menu.instance()
	get_parent().add_child(NEXT_SCENE)
	remove_child(CORE_NODE)
	queue_free()
