extends Sprite

# Move along the path and rotate towards the next path point

export(float) var move_speed = 100.0;
export(float) var rotation_speed = 5.0
export(float) var trigger_distance = 10.0;

var reached_current_target : bool = false
var current_target
var target_angle
var path;

onready var nav2D = get_parent().find_node("Navigation2D")

func _ready():
	set_process(false)

func _process(delta):
	
	if (rotation != target_angle):
		rotate_towards_next_path_pos(delta)
	
	move_along_path(move_speed * delta)
	
	if(reached_target()):
		$"Update Navigation Timer".stop()
		set_process(false)


func move_along_path(distance):
	var distance_between_points = position.distance_to(path[0])
	position = position.linear_interpolate(path[0], distance / distance_between_points)

func rotate_towards_next_path_pos(delta):
	var angle_dif = -short_angle_dist(rotation, target_angle)
	if(abs(angle_dif) < 0.05):
		rotation = target_angle
	else:
		rotation = rotation - rotation_speed * delta * sign(angle_dif)

func short_angle_dist(from, to):
	var max_angle = TAU
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference

func reached_target()->bool:
	var distance_between_points = position.distance_to(path[0])
	if(path.size() <= 1):
		if(distance_between_points <= trigger_distance):
			return true
	return false

func update_navigation_path(var start_position, var end_position):
	path = nav2D.get_simple_path(start_position,end_position, true)
	path.remove(0)
	



# SIGNALS

func _on_Update_Navigation_Timer_timeout():
	update_navigation_path(global_position, current_target.global_position)
	target_angle = path[0].angle_to_point(position)

func _on_Node2D_start_missile(target):
	current_target = target
	update_navigation_path(global_position, target.global_position)
	target_angle = path[0].angle_to_point(position)
	$"Update Navigation Timer".start()
	set_process(true)


