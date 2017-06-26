extends KinematicBody2D

export var rotation_speed = PI/2
export var max_acceleration = 20
export var max_speed = 8
export var friction = 0.05
export var bounce = 1.3
export var reload_time = 0.5

onready var bullet = preload("res://Scenes/Objects/Player Bullet.tscn")
#onready var SHIP_CORES = preload("res://Scenes/Ship Parts/Ship Cores Library.tscn").instance()
onready var bullet_container = get_node("BulletContainer")
onready var core_sprite = get_node("Sprite")

var screen_size = Vector2()
var position = Vector2()
var velocity = Vector2()
var player_to_mouse = Vector2()
var player_to_mouse_angle = 0

#var RayNode
var cooldown = 0
var delay = 0

func _ready():
	screen_size = get_viewport_rect().size
	set_pos(screen_size / 2)
	set_fixed_process(true)
	
	#attempt at adapting camera
	#set("limit/right", screen_size.x)
	#set("limit/bottom", screen_size.y)
	
	#RayNode = get_node("RayCast2D")

func spawn_ship(core, x, y):
	position = Vector2(x, y)
	set_pos(position)

func _fixed_process(delta):
	position = get_pos()
	delay += 1
	if (delay == 15):
		delay = 0
		core_sprite.set_frame(9+((core_sprite.get_frame()+1) % 3))
		#diagnostic
		if (Input.is_action_pressed("ui_help")):
			print('velocity: ', velocity)
			print('position: ', position)
			print('direction: ', get_rot())
			print('mouse: ', get_viewport().get_mouse_pos())
	#rotate
	player_to_mouse = get_global_mouse_pos() - position
	player_to_mouse_angle = get_rot() - player_to_mouse.angle()
	if (player_to_mouse_angle != 0):
		set_rot(get_rot() + get_angle_to(get_global_mouse_pos())/4)
	
	#motion
	if (Input.is_action_pressed("ui_up")):
		velocity += Vector2(0, -1)*delta*max_acceleration
		#RayNode.set_rotd(180)
	
	if (Input.is_action_pressed("ui_down")):
		velocity += Vector2(0, 1)*delta*max_acceleration
		#RayNode.set_rotd(0)
	
	if (Input.is_action_pressed("ui_left")):
		velocity += Vector2(-1, 0)*delta*max_acceleration
		#RayNode.set_rotd(-90)
		
	if (Input.is_action_pressed("ui_right")):
		velocity += Vector2(1, 0)*delta*max_acceleration
		#RayNode.set_rotd(90)
	
	if (velocity.length() < 0.2):
		velocity = Vector2(0, 0)
	
	#collision
	if is_colliding():
		if (velocity.length() == 0):
			velocity += get_collision_normal() * max_acceleration * bounce
		else:
			velocity += get_collision_normal() * get_collider().velocity.length() * bounce
	
	if (velocity.length() > max_speed):
		velocity = velocity.normalized() * max_speed
	else:
		velocity = velocity * (1-friction)
	
	if position.x >= screen_size.width:
		position.x = 0
	if position.x < 0:
		position.x = screen_size.width
	if position.y >= screen_size.height:
		position.y = screen_size.height
	if position.y < 0:
		position.y = 0
	
	set_pos(position)
	
	move(velocity)