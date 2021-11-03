extends Navigation2D

export(float) var rocket_speed = 400.0;

var travel_towards_target : bool = false
var path = []

onready var rocket	= $Rocket
onready var target = $Drone
onready var debug_path = $Line2D

func _process(delta):
	if(travel_towards_target):
		_update_navigation_path(rocket.position,target.position)
		var travel_distance = rocket_speed * delta
		move_along_path(travel_distance)

func _unhandled_input(event):
	if not event.is_action_pressed("click"):
		return
	travel_towards_target = not travel_towards_target

func move_along_path(distance):
	var last_point = rocket.position
	var distance_between_points = last_point.distance_to(path[0])
	rocket.position = last_point.linear_interpolate(path[0], distance / distance_between_points)
	
	
	
func _update_navigation_path(start_position, end_position) :
	# get_simple_path is part of the Navigation2D class.
	# It returns a PoolVector2Array of points that lead you
	# from the start_position to the end_position.
	path = get_simple_path(start_position, end_position, true)
	debug_path.points = path
	if(path.size() > 1):
		path.remove(0)	# The first point is always the start_position.
