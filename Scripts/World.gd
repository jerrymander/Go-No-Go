extends Node2D

# class member variables go here, for example:

onready var GALAXY_TILESET = get_node("TileMap")
var screen_size = Vector2()
var screen_tiles = Vector2()
var position = Vector2()


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
		
	pass
