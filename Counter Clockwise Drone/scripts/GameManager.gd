extends Node2D

export(NodePath) var drone # a "path" to the drone node in the scene

var con_res

signal start_missiles(target)


# find Missile Node and connect the "start_missiles" signal to "_on_Node2D_start_missiles" func 
#in the Missile script

func _ready():
	
	for node in get_children():
		var node_script = node.get_script()
		if node_script != null:
			if node_script.get_path().get_file() == "MissileV2.gd":
				con_res = connect("start_missiles",node,"_on_Node2D_start_missile")
				if(con_res != OK):
					print("failed to connect to node")				
	emit_signal("start_missiles",get_node(drone))
	
func game_over():
	$GameOver_Timer.start()

func _on_GameOver_Timer_timeout():
	$CanvasLayer/GameOver_Menu.visible = true
