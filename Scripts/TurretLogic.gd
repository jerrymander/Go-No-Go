extends Node2D

export var RELOAD_TIME = 0.5
export var BULLET_ID = 1
export var RECOIL = 2

onready var BULLET_LIBRARY = preload("res://Scenes/Objects/Bullet Library.tscn").instance()
onready var BULLET_CONTAINER = get_node("BulletContainer")

#var PLAYER = get_parent().get_parent()

var ROTATION = 0
var COOLDOWN = 0


func _ready():
	set_fixed_process(true)
	pass

func fire():
	var B = BULLET_LIBRARY.generate_bullet(BULLET_ID)
	BULLET_CONTAINER.add_child(B)
	B.start_at(get_global_rot() + PI, get_node("BulletSpawn").get_global_pos())

func _fixed_process(delta):
	#shooting
	COOLDOWN += 1
	if (Input.is_action_pressed("shoot")):
		if (COOLDOWN > RELOAD_TIME * 60):
			fire()
			#PLAYER.velocity -= PLAYER.player_to_mouse.normalized() * delta * PLAYER.max_acceleration * RECOIL
			COOLDOWN = 0
