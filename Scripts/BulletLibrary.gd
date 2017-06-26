extends Node

func generate_bullet(index):
	return get_child(index).duplicate()
	