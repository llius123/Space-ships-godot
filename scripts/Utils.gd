extends Node


func get_node_by_name(name: String):
	return get_tree().get_root().find_child(name, true, false)
