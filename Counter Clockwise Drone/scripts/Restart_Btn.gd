extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed",self,"on_Restart_Btn_pressed")
	connect("mouse_entered",self,"on_Restart_Btn_Focus")

func on_Restart_Btn_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func on_Restart_Btn_Focus():
	grab_focus()
