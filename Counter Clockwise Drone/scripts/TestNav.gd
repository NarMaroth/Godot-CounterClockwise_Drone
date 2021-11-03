extends Node2D


onready var nav_2d : Navigation2D = $Navigation2D
onready var line_2d : Line2D = $Line2D
var speed : = 400.0
func _ready():
	var path : = nav_2d.get_simple_path(global_position,$icon.global_position)
	line_2d.points = path

func _process(delta):
	move_along_path(speed *  delta)
	pass

func move_along_path(distace : float) -> void:
	pass	
