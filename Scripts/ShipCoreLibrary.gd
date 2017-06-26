extends Node

func generate_core(index):
	print(get_child(index).get_name())
	return get_child(index).duplicate()