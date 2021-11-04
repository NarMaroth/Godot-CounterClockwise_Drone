extends Sprite

export(float) var missile_speed = 200.0;
export(float) var trigger_distance = 10.0;

var reached_current_target : bool = false
var current_target
var path;

onready var nav2D = get_parent().find_node("Navigation2D")

func _ready():
	set_process(false)

func _process(delta):
	update_navigation_path(global_position, current_target.global_position)
	move_along_path(missile_speed * delta)
	if(reached_current_target):
		set_process(false)

func move_along_path(distance):
	var distance_between_points = position.distance_to(path[1])
	if(path.size() <= 2):
		if(distance_between_points <= trigger_distance):
			reached_current_target = true
			return
	position = position.linear_interpolate(path[1], distance / distance_between_points)

func update_navigation_path(var start_position, var end_position):
	path = nav2D.get_simple_path(start_position,end_position, true)
	


func _on_Node2D_start_missile(target):
	current_target = target
	set_process(true)
