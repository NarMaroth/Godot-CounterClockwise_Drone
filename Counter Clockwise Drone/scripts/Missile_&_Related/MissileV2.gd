extends KinematicBody2D
# move always forwards and rotate towards the path[0] position 

export(float) var move_speed = 6000.0;
export(float) var rotation_speed = 150.0
export(float) var trigger_distance = 45.0;

export(PackedScene) var smoke_cloud
export(PackedScene) var explosion

var target
var nav2D

var target_angle
var path;
var reached_path_end : bool = false


func init():
	rotation_speed = deg2rad(rotation_speed)
	update_navigation_path(global_position, target.global_position)
	target_angle = path[0].angle_to_point(position)
	$UpdateNavigationTimer.start()
	$SmokeCloudTimer.start()

func _process(delta):
	
	if (rotation != target_angle):
		rotate_towards_next_path_pos(delta)
		
	move_forward(delta)
	
	if(reached_target()):
		instantiate_packed_scene(explosion)
		target.destroy()
		queue_free()


func move_forward(delta):
# warning-ignore:return_value_discarded
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

func instantiate_packed_scene(packed_scene):
	var clone = packed_scene.instance() 
	clone.position = position
	get_parent().add_child(clone)



func _on_Update_Navigation_Timer_timeout():
	update_navigation_path(global_position, target.global_position)
	target_angle = path[0].angle_to_point(position)
	


func _on_SmokeCloudTimer_timeout():
	instantiate_packed_scene(smoke_cloud)
