extends Node

func generate_asteroid(index):
	return get_child(index).duplicate()

