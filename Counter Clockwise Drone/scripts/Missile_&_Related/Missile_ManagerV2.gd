extends Node

export(PackedScene) var missile_scn
export(NodePath) var navigation_path
onready var navigation = get_node(navigation_path)
export(NodePath) var drone_path
onready var drone = get_node(drone_path)

onready var origin = $Origin

var active_missiles :=  Array()


func Generate_missile()->Node:
	var missile_clone = missile_scn.instance()
	add_child(missile_clone)
	print(missile_clone.name)
	missile_clone.position = origin.position;
	missile_clone.rotation_degrees = origin.rotation_degrees;
	active_missiles.push_back(missile_clone)
	return missile_clone
	
func Launch_missile():
	var missile = Generate_missile()
	missile.target = drone
	missile.nav2D = navigation
	missile.init()
	
func Destroy_All_Active_Missiles():
	while active_missiles.size() > 0:
		active_missiles[0].Explode()
		active_missiles.remove(0)
