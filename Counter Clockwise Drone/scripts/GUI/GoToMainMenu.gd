extends Button



var mainmenu_scene = "res://scenes/GUIs/MainMenu.tscn"




func _on_MainMenu_Btn_pressed() -> void:
	get_tree().change_scene(mainmenu_scene)
