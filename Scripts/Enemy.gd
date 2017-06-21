extends KinematicBody2D

export var F_max_speed = 10
export var F_max_acceleration = 10
export var bounce = 1.5
export var hp = 10
export var shields = 0

var enemy_id
var velocity = Vector2()
var position = Vector2()
var player_position = Vector2()

var screen_size = get_viewport_rect().size
var extents

var delay = 0

onready var F_sprite = get_node("F_Sprites")
#onready var player = preload("res://Scenes/Player.tscn")

func _ready():
	screen_size = get_viewport_rect().size
	extents = F_sprite.get_texture().get_size() / 4
	set_fixed_process(true)

func spawn(map_size):
	randomize()
	enemy_id = randi() % 2
	position = Vector2(0, rand_range(0, map_size.y))
	set_pos(position)

func _fixed_process(delta):
	
	delay += 1
	
	if (delay == 15):
		delay = 0
		F_sprite.set_frame(3 * enemy_id + ((F_sprite.get_frame()+1) % 3))
		velocity += Vector2(rand_range(0,5),0).rotated(rand_range(0,2*PI)) * F_max_acceleration * delta
	
	if is_colliding():
		if (velocity.length() == 0):
			velocity = get_collision_normal() * 2 * bounce
		else:
			velocity += get_collision_normal() * (get_collider().velocity.length() * bounce)
	
	if (velocity.length() > F_max_speed):
		velocity = velocity.normalized()*F_max_speed
	
	else:
		velocity = velocity * (0.98)
	
	move(velocity)
	
	#border control
	position = get_pos()
	if position.x > screen_size.width + extents.width:
		position.x = -extents.width
	if position.x < -extents.width:
		position.x = screen_size.width + extents.width
	if position.y > screen_size.height + extents.height:
		position.y = -extents.height
	if position.y < -extents.height:
		position.y = screen_size.height + extents.height
	set_pos(position)
	#player_position = get_node("res://Scenes/Player.xml").get_node("Core").get_global_pos()
	#set_rot(get_rot() + get_angle_to(player_position)/10)
	
	
