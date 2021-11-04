extends Sprite

export(float) var missile_speed = 200.0;
export(float) var trigger_distance = 10.0;

var reached_current_target : bool = false
var current_target
var target_pos : Vector2
var path;

onready var nav2D = get_parent().find_node("Navigation2D")

func _ready():
	set_process(false)

func _process(delta):
	#if(current_target.global_position != target_pos):
	target_pos = current_target.global_position
	update_navigation_path(global_position, target_pos)
	move_along_path(missile_speed * delta)
	look_at(path[1])
	
	if(reached_target()):
		set_process(false)


func move_along_path(distance):
	var distance_between_points = position.distance_to(path[1])
	position = position.linear_interpolate(path[1], distance / distance_between_points)

func reached_target()->bool:
	var distance_between_points = position.distance_to(path[1])
	if(path.size() <= 2):
		if(distance_between_points <= trigger_distance):
			return true
	return false

func update_navigation_path(var start_position, var end_position):
	path = nav2D.get_simple_path(start_position,end_position, true)
	


func _on_Node2D_start_missile(target):
	current_target = target
	target_pos = target.global_position
	update_navigation_path(global_position, target_pos)
	set_process(true)
