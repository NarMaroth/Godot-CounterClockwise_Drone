extends KinematicBody2D


export (int) var mov_speed = 100
export (int) var rot_speed = 50



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_pressed("ui_left")):
		rotation_degrees -= rot_speed * delta;

	if (Input.is_action_pressed("ui_right")):
		rotation_degrees += rot_speed * delta;


	if(Input.is_action_pressed("ui_up")):
# warning-ignore:return_value_discarded
		move_and_slide(Vector2(0,-1).rotated(rotation) * mov_speed)
	if(Input.is_action_pressed("ui_down")):
# warning-ignore:return_value_discarded
		move_and_slide(Vector2(0,1).rotated(rotation) * mov_speed)
