extends Area2D
var cant_crate_variants = 5

signal crateReceived_signal

export(PackedScene) var crate_scn
export(NodePath) var receiver_manager_path
onready var receiver_manager = get_node(receiver_manager_path)
export(NodePath) var gameUI_path
onready var game_ui = get_node(gameUI_path)

var current_crate_variant
var crate_clone

onready var animPlayer = $Crate_Sprite/AnimationPlayer
var rng = RandomNumberGenerator.new()


func _ready():
	
	Dispatch_create()
	

func Dispatch_create():
	current_crate_variant = get_random_crate_variant()
	animPlayer.play("Loaded_0"+str(current_crate_variant))
	
func Add_crate_to_drone(body):
	crate_clone = crate_scn.instance()
	body.add_child(crate_clone)
	crate_clone.position = Vector2.ZERO;
	crate_clone.set_variant(current_crate_variant)

func get_random_crate_variant()->int:
	rng.randomize()
	return rng.randi_range(0,cant_crate_variants-1)


func _on_Crate_Dispatcher_body_entered(body):
	if(body.name != "Drone"):return
	
	if(body.transporting_create == false):
		body.transporting_create = true;
		animPlayer.play("Empty")
		Add_crate_to_drone(body)
		receiver_manager.Generate_Crate_Receiver(self,current_crate_variant)
	
func On_Crate_Received():
	crate_clone.queue_free()
	Dispatch_create()
	emit_signal("crateReceived_signal")
	

