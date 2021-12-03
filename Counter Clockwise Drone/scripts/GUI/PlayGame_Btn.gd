extends Button


var game_scene = "res://scenes/Test_Scenes/TestSceneV3.tscn"



func _on_Button_pressed() -> void:
	get_tree().change_scene(game_scene)
