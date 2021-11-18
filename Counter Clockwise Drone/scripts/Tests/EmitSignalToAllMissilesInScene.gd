extends Node

export(NodePath) var drone # a "path" to the drone node in the scene

signal start_missile(target)

func _ready():
	for node in get_children():
		var node_script = node.get_script()
		if node_script != null:
			if node_script.get_path().get_file() == "Missile.gd":
				connect("start_missile",node,"_on_Node2D_start_missile") 
				
	# find Missile Node and connect the "start_missile" signal to "_on_Node2D_start_missile" func 
	#in the Missile script


	emit_signal("start_missile",get_node(drone))
