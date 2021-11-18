extends Node

export(NodePath) var missile_manager_path
onready var missile_manager = get_node(missile_manager_path)
export(NodePath) var gameover_menu_path
onready var gameover_menu = get_node(gameover_menu_path)


func _ready():
	$StartGame_Timer.start()

func trigger_gameover():
	$GameOver_Timer.start()

func _on_GameOver_Timer_timeout():
	gameover_menu.visible = true


func _on_StartGame_Timer_timeout():
	missile_manager.launch_missile()
