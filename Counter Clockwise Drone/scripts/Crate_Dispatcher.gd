extends Area2D
var cant_crate_variants = 5

export(PackedScene) var crate_scn
export(NodePath) var receiver_manager_path

var current_crate_variant
var crate_clone
var receiver_manager

onready var animPlayer = $Crate_Sprite/AnimationPlayer
var rng = RandomNumberGenerator.new()


func _ready():
	receiver_manager = get_node(receiver_manager_path)
	dispatch_create()
	

func dispatch_create():
	current_crate_variant = get_random_crate_variant()
	animPlayer.play("Loaded_0"+str(current_crate_variant))

func get_random_crate_variant()->int:
	rng.randomize()
	return rng.randi_range(0,cant_crate_variants-1)
	
func add_crate_to_drone(body):
	crate_clone = crate_scn.instance()
	body.add_child(crate_clone)
	crate_clone.position = Vector2.ZERO;
	crate_clone.set_variant(current_crate_variant)



func _on_Crate_Dispatcher_body_entered(body):
	if(body.name != "Drone"):return
	
	if(body.transporting_create == false):
		body.transporting_create = true;
		animPlayer.play("Empty")
		add_crate_to_drone(body)
		receiver_manager.generate_crate_receiver(self,current_crate_variant)
	
func on_Crate_Received():
	crate_clone.queue_free()
	dispatch_create()


