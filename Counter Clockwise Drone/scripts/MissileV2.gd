extends KinematicBody2D

# move always forwards and rotate towards the path[0] position 

export(float) var move_speed = 6000.0;
export(float) var rotation_speed = 150.0
export(float) var trigger_distance = 10.0;
export(PackedScene) var smoke_cloud

var current_target
var target_angle
var path;
var reached_path_end : bool = false

onready var nav2D = get_parent().find_node("Navigation2D")

func _ready():
	rotation_speed = deg2rad(rotation_speed)
	set_process(false)

func _process(delta):
	
	if (rotation != target_angle):
		rotate_towards_next_path_pos(delta)
		
	move_forward(delta)
	
	if(reached_target()):
		$UpdateNavigationTimer.stop()
		$SmokeCloudTimer.stop()
		set_process(false)

	

func move_forward(delta):
	move_and_slide(Vector2(1, 0).rotated(rotation) * move_speed * delta)

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



#	SIGNALS

func _on_Update_Navigation_Timer_timeout():
	update_navigation_path(global_position, current_target.global_position)
	target_angle = path[0].angle_to_point(position)


func _on_Node2D_start_missile(target):
	current_target = target
	update_navigation_path(global_position, current_target.global_position)
	target_angle = path[0].angle_to_point(position)
	$UpdateNavigationTimer.start()
	$SmokeCloudTimer.start()
	set_process(true)
	


func _on_SmokeCloudTimer_timeout():
	var smokeClone = smoke_cloud.instance() 
	smokeClone.position = position
	get_parent().add_child(smokeClone)
