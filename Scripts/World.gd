extends Node2D

onready var GALAXY_TILESET = get_node("TileMap")
onready var asteroid_library = preload("res://Scenes/Objects/AsteroidLibrary.tscn").instance()
onready var asteroid_container = get_node("AsteroidContainer")
onready var enemy = preload("res://Scenes/Enemies/Enemy.tscn")
onready var enemy_container = get_node("EnemyContainer")

var next_scene

var map_size = Vector2(1024, 576)
var ESC_TIMER = 0
var ESC_SEC = 0

func _ready():
	var screen_size = get_viewport_rect().size
	var screen_tiles = Vector2(1 + ceil(screen_size.width/32), 1 + ceil(screen_size.height)/32)
	
	randomize()
	for i in range (0, screen_tiles.x):
		for j in range (0, screen_tiles.y):
			GALAXY_TILESET.set_cell(i,j,randi()%8)
		
	for i in range (0, screen_tiles.x):
		for j in range (0, screen_tiles.y):
			if (randi()%200 == 0):
				GALAXY_TILESET.set_cell(i,j,9)
			if (randi()%200 == 1):
				GALAXY_TILESET.set_cell(i,j,8)
		
	set_fixed_process(true)

func _fixed_process(delta):
	if (Input.is_action_pressed("ui_cancel")):
		ESC_TIMER += 1
		if (ESC_TIMER == 60):
			if (ESC_SEC == 0):
				print ("Escaping to main menu in...")
			ESC_SEC += 1
			print (4-ESC_SEC)
			ESC_TIMER = 0
		elif (ESC_SEC == 4):
			next_scene = get_parent().main_menu.instance()
			get_parent().add_child(next_scene)
			queue_free()
	else:
		ESC_TIMER = 0
		ESC_SEC = 0

func _on_ScoutSpawnTimer_timeout():
	var e = enemy.instance()
	enemy_container.add_child(e)
	e.spawn(map_size)
	print('Warning: Enemy Sighted!')
	
func _on_AsteroidSpawnTimer_timeout():
	var new_asteroid = asteroid_library.generate_asteroid(randi() % 12)
	new_asteroid.set_pos(Vector2(rand_range(0, map_size.x), rand_range(0, map_size.y)))
	asteroid_container.add_child(new_asteroid)
	print('Warning: Asteroids Ahead!')
	
	