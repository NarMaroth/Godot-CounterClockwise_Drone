extends KinematicBody2D


export (int) var mov_speed = 100
export (int) var rot_speed = 50

var transporting_create : bool
var move_dir := Vector2()

export(NodePath) var gamemanager_path
onready var gamemanager = get_node(gamemanager_path)

func _ready():
	transporting_create = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_pressed("ui_left")):
		rotation_degrees -= rot_speed * delta

	if (Input.is_action_pressed("ui_right")):
		rotation_degrees += rot_speed * delta

	if(Input.is_action_pressed("ui_up")):
		move_dir.y = -1
	elif(Input.is_action_pressed("ui_down")):
		move_dir.y = 1	
	else:
		move_dir.y = 0
		
# warning-ignore:return_value_discarded
	move_and_slide(move_dir.rotated(rotation) * mov_speed)
	
func destroy():
	gamemanager.trigger_gameover()
	queue_free()
