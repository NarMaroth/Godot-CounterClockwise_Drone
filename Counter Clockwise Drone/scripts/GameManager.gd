extends Node2D

export(NodePath) var drone

signal start_missile(target)


# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("start_missile",get_node(drone))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
