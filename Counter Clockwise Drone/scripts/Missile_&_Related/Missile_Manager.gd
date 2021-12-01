extends Node

export(PackedScene) var missile_scn


export(NodePath) var navigation_path
onready var navigation = get_node(navigation_path)
export(NodePath) var drone_path
onready var drone = get_node(drone_path)
onready var origin = $Origin


func generate_missile()->Node:
	var missile_clone = missile_scn.instance()
	add_child(missile_clone)
	missile_clone.position = origin.position;
	missile_clone.rotation_degrees = origin.rotation_degrees;
	return missile_clone
	
func launch_missile():
	var missile = generate_missile()
	missile.target = drone
	missile.nav2D = navigation
	missile.init()
	

