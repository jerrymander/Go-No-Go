extends Area2D

export var Speed = 700

var Velocity = Vector2()
var delay = 0
onready var bullet_sprite = get_node("Sprite")

func _ready():
	set_fixed_process(true)

func start_at(direction, position):
		set_rot(direction)
		set_pos(position)
		Velocity = Vector2(0, Speed).rotated(direction)
		

func _fixed_process(delta):
	set_pos(get_pos() + Velocity * delta)
	
	delay += 1
	
	if (delay == 15):
		delay = 0
		bullet_sprite.set_frame(((bullet_sprite.get_frame()+1) % 4))


func _on_Lifetime_timeout():
	queue_free()
