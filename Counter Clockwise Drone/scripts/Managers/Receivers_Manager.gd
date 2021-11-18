extends Node

export (PackedScene) var crate_receiver_scn

var receiver_spots
var receiver_clone
var rng = RandomNumberGenerator.new()

func _ready():
	receiver_spots = get_children()
	
func generate_crate_receiver(dispatcher_node,variant:int):
	generate_receiver(variant)
	var res = receiver_clone.connect("create_received",dispatcher_node,"on_Crate_Received")
	if(res != 0):
		print("Failed to connect {Receiver} with {Dispatcher}")
		
	
		
func generate_receiver(variant:int):
	var receiver_spot = get_random_receiver_spot()
	receiver_clone = crate_receiver_scn.instance()
	receiver_spot.add_child(receiver_clone)
	receiver_clone.position = Vector2.ZERO;
	receiver_clone.rotation_degrees = 0;
	receiver_clone.set_sprite(variant)
	
func get_random_receiver_spot()->Node2D:
	rng.randomize()
	return receiver_spots[rng.randi_range(0,receiver_spots.size()-1)]
