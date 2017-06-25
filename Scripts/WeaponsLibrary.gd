extends Node

func generate_weapon(index):
	return get_child(index).duplicate()