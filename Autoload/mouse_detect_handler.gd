extends Node

# This autoloaded script handles figuring out what cards and zones are under mouse. It also will figure out
# which should be allowed to accept mouse input (using z index mainly)

# Stores mouse detectors under mouse
var nodes_under_mouse: Array
# Stores detector that is under mouse with highest z index
var top_node: MouseDetector = null : set = _set_top_node

# Called by mouse detectors when mouse starts being on their parent
func add_under_mouse(detector: MouseDetector) -> void:
	if top_node == null:
		top_node = detector
	else:
		if is_node_on_top(detector, top_node):
			nodes_under_mouse.append(top_node)
			top_node = detector
		else:
			nodes_under_mouse.append(detector)
		
# Called by mouse detectors when mouse ends being on their parent
func remove_under_mouse(detector: MouseDetector) -> void:
	if top_node == detector:
		top_node = null
		if nodes_under_mouse.size() > 1:
			find_new_top_node()
		elif nodes_under_mouse.size() > 0:
			top_node = nodes_under_mouse[0]
			nodes_under_mouse.clear()
	else:
		nodes_under_mouse.erase(detector)
		
# Will figure out new top node from within nodes under mouse array.
func find_new_top_node() -> void:
	for i in range(nodes_under_mouse.size()):
		if top_node == null: 
			top_node = nodes_under_mouse[i]
		elif is_node_on_top(nodes_under_mouse[i], top_node):
			var temp = nodes_under_mouse[i]
			nodes_under_mouse[i] = top_node
			top_node = temp
		
# Will figure out if added detector is above others. If true will set top node to that and old top node is added
# with other nodes under mouse, otherwise will just add detector with other nodes under mouse.
func figure_out_if_added_detector_top(added_detect: MouseDetector) -> void:
	if is_node_on_top(added_detect, top_node):
		nodes_under_mouse.append(top_node)
		top_node = added_detect
	else:
		nodes_under_mouse.append(added_detect)
	
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
	if youngest_shared_parent == null:
		return false
	var a_index: int = -1
	var b_index: int = -1
	for child in youngest_shared_parent.get_children():
		if child.is_ancestor_of(a):
			a_index = child.get_index()
		if child.is_ancestor_of(b):
			b_index = child.get_index()
	return a_index > b_index
	
# Finds 'youngest' (furthest from root) parent both node perameters share.
func find_youngest_similar_parent(a: Node, b: Node) -> Node:
	var parents := get_parents(a)
	for i in range(parents.size()):
		if not parents[i].is_ancestor_of(b):
			if i == 0: printerr("No parents are shared between {0} and {1}".format([a.name, b.name]))
			return parents[i - 1] if i > 0 else null
	return null
	
func _set_top_node(value) -> void:
	if top_node != null: top_node.mouse_on = false
	#if value != top_node:
		#print("Top node is: %s" % (value.get_parent().name if value != null else "null"))
	top_node = value
	if top_node != null: top_node.mouse_on = true
