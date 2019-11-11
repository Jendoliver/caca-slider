# Things that should exist in the Node class, but don't
extends Node


func reparent(node: Node, new_parent: Node, keep_position = false):
	var prev_pos = node.global_position
	node.get_parent().remove_child(node)
	new_parent.add_child(node)
	if keep_position:
		node.global_position = prev_pos


func repr(node: Node, deep = false):
	var output = """
		%s (Ptr: %s) repr:
		------------------
		Position: %s  (Global: %s )
		Modulate: %s   (Self: %s)
		Children:""".dedent() % [
			node.name, 
			node, 
			node.get("position"), 
			node.get("global_position"), 
			node.get("modulate"), 
			node.get("self_modulate")
		]
	for child in node.get_children():
		output += _child_repr(child, deep)
	output += "---------------\n%s repr END\n" % node.name
	return output


func _child_repr(node: Node, deep = false, depth_level = 0):
	var indentation = ""
	for i in range(depth_level):
		indentation += '\t'
	if deep:
		var children_repr = ""
		for child in node.get_children():
			children_repr += _child_repr(child, deep, depth_level + 1)
		if children_repr != "":
			return ("""
{indentation}- Name: %s  (Ptr: %s)
{indentation}- Position: %s  (Global: %s )
{indentation}- Modulate: %s  (Self: %s)
{indentation}- Children: %s""" % [node.name, node, node.get("position"), 
node.get("global_position"), node.get("modulate"), 
node.get("self_modulate"), children_repr]).format({"indentation": indentation})

	return ("""
{indentation}- Name: %s  (Ptr: %s)
{indentation}- Position: %s  (Global: %s )
{indentation}- Modulate: %s  (Self: %s)
""" % [node.name, node, node.get("position"), 
	node.get("global_position"), node.get("modulate"), 
	node.get("self_modulate")]).format({"indentation": indentation})
