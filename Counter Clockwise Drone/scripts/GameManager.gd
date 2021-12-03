extends Node

export(NodePath) var missile_manager_path
onready var missile_manager = get_node(missile_manager_path)
export(NodePath) var gameover_menu_path
onready var gameover_menu = get_node(gameover_menu_path)
export(NodePath) var gameUI_path
onready var game_ui = get_node(gameUI_path)
export(NodePath) var crateDispatcher_path
onready var crateDispatcher = get_node(crateDispatcher_path)


func _ready():
	game_ui.connect("startChasingTimer_timeout",self,"On_StartChasingBar_Timeout")
	game_ui.connect("nextMissileTimer_timeout",self,"On_NextMissileBar_Timeout")
	crateDispatcher.connect("crateReceived_signal",self,"On_Crate_Received")
	
func Trigger_gameover():
	missile_manager.Destroy_All_Active_Missiles()
	game_ui.ResetAndStop_Timers()
	$GameOver_Timer.start()

func _on_GameOver_Timer_timeout():
	gameover_menu.visible = true


func On_StartChasingBar_Timeout():
	missile_manager.Launch_missile()
	
func On_NextMissileBar_Timeout():
	missile_manager.Launch_missile()

func On_Crate_Received():
	var crateDeliveredAmmount = game_ui.Get_CreateDelivered_Label()+1
	game_ui.Set_CreateDelivered_Label(crateDeliveredAmmount)
	
	game_ui.Reset_Timers();
	missile_manager.Destroy_All_Active_Missiles()
