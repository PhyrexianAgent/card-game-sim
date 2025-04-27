extends Node

# This autoloaded script handles figuring out what cards and zones are under mouse. It also will figure out
# which should be allowed to accept mouse input (using z index mainly)

# Stores mouse detectors under mouse
var nodes_under_mouse: Array
# Stores detector that is under mouse with highest z index
var top_node

func add_under_mouse(detector: MouseDetector) -> void:
	pass
	
# Will add z indexes of node and its parents (unless node's z index is not set to relative).
func get_actual_z_index(node: Node2D) -> int:
	if node.get_parent() == null or not node.get_parent() is Node2D:
		return node.z_index + 1
	else:
		return node.z_index + 1 + get_actual_z_index(node.get_parent())
	return 1
	
# Will get list of parents for a node. In same order as scene tree (oldest to youngest).
func get_parents(node: Node) -> Array:
	var parents: Array
	var parent = node.get_parent()
	while parent != null:
		parents.insert(0, parent)
		parent = parent.get_parent()
	return parents
	
# Checks if node a is above node b
func is_node_on_top(a: Node, b: Node) -> bool:
	if a.get_parent() == b.get_parent():
		return a.get_index() > b.get_index()
	var youngest_shared_parent := find_youngest_similar_parent(a, b)
	return false
	
# Finds 'youngest' (furthest from root) parent both node perameters share.
func find_youngest_similar_parent(a: Node, b: Node) -> Node:
	var parents := get_parents(a)
	for i in range(parents.size()):
		if not parents[i].is_ancestor_of(b):
			if i == 0: printerr("No parents are shared between {0} and {1}".format([a.name, b.name]))
			return parents[i - 1] if i > 0 else null
	return null
