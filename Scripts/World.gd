extends Node2D

# class member variables go here, for example:

onready var GALAXY_TILESET = get_node("TileMap")
onready var asteroid = preload("res://Scenes/Asteroids.tscn")
onready var asteroid_library = preload("res://Scenes/Objects/AsteroidLibrary.tscn").instance()
onready var asteroid_container = get_node("AsteroidContainer")
onready var enemy = preload("res://Scenes/Enemy.tscn")
onready var enemy_container = get_node("EnemyContainer")

var map_size = Vector2(1024, 576)

func _ready():
	var screen_size = get_viewport_rect().size
	var screen_tiles = Vector2(1 + ceil(screen_size.width/32), 1 + ceil(screen_size.height)/32)
	
	randomize()
	for i in range (0, screen_tiles.x):
		for j in range (0, screen_tiles.y):
			GALAXY_TILESET.set_cell(i,j,randi()%8)
		
	randomize()
	for i in range (0, screen_tiles.x):
		for j in range (0, screen_tiles.y):
			if (randi()%200 == 0):
				GALAXY_TILESET.set_cell(i,j,9)
			if (randi()%200 == 1):
				GALAXY_TILESET.set_cell(i,j,8)
		
	set_fixed_process(true)

func _fixed_process(delta):
	ParallaxBackground
	

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
	
	