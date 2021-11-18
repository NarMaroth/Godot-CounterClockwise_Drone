extends Control


func _ready():
	connect("visibility_changed",self,"_on_GameOver_Menu_visibility_changed")
	disable_all_buttons()

func disable_all_buttons():
	for node in get_children():
		if node is Button:
			node.disabled = true
	
func enable_all_buttons():
	for node in get_children():
		if node is Button:
			node.disabled = false

func _on_GameOver_Menu_visibility_changed():
	if(visible == true):
		get_tree().paused = true
		enable_all_buttons()
		
