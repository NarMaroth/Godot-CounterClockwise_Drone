extends Node2D

export(NodePath) var drone # a "path" to the drone node in the scene

var con_res

signal start_missile(target)


# find Missile Node and connect the "start_missile" signal to "_on_Node2D_start_missile" func 
#in the Missile script
func _ready():
	
	for node in get_children():
		var node_script = node.get_script()
		if node_script != null:
			if node_script.get_path().get_file() == "MissileV2.gd":
				con_res = connect("start_missile",node,"_on_Node2D_start_missile")
				if(con_res != OK):
					print("failed to connect to node")
							
	emit_signal("start_missile",get_node(drone))

