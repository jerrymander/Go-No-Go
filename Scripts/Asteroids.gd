extends KinematicBody2D

export var bounce = 1.4
export var hp = 10
export var size = 5

var velocity = Vector2()
var rotation_speed
var position
var screen_size
var extents

#onready var sparks = get_node("/World/AsteroidLibrary/CollisionSparks")

func _ready():
	add_to_group("asteroids")
	randomize()
	set_fixed_process(true)
	velocity = Vector2(rand_range(30, 100), 0).rotated(rand_range(0,2*PI))
	rotation_speed = rand_range(-PI, PI)
	screen_size = get_viewport_rect().size
	extents = get_node("Sprite").get_texture().get_size() / 2

func init(init_size, init_pos, init_vel):
	size = init_size
	if init_vel.length() > 0:
		velocity = init_vel
	else:
		velocity = Vector2(rand_range(30, 100), 0).rotated(rand_range(0,2*PI))
	rotation_speed = rand_range(-PI, PI)
	

func _fixed_process(delta):
	
	set_rot(get_rot() + rotation_speed * delta)
	move(velocity * delta)
	
	if is_colliding():
		velocity += get_collision_normal() * (get_collider().velocity.length() * bounce)
		#sparks.set_global_pos(get_collision_pos())
		#sparks.set_emitting(true)
	
	if velocity.length() >= 10:
		velocity = velocity.normalized() * 10
	
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

func take_damage(damage):
	hp -= damage
	if hp <= 0:
		explode()

func explode():
	queue_free()
