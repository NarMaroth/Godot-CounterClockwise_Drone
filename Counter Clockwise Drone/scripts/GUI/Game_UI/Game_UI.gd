extends Control

signal startChasingTimer_timeout
signal nextMissileTimer_timeout

onready var startchasing_bar = $StartChasing_Bar
onready var nextmissile_bar = $NextMissile_Bar

func _ready():
	startchasing_bar.connect("timeout_signal",self,"On_StartChasingBar_Timeout")
	nextmissile_bar.connect("timeout_signal",self,"On_NextMissileBar_Timeout")
	startchasing_bar.Start_Timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func Reset_Timers():
	nextmissile_bar.Stop_Timer()
	startchasing_bar.Start_Timer()

func ResetAndStop_Timers():
	Reset_Timers()
	startchasing_bar.Stop_Timer()

func Set_CreateDelivered_Label(ammount):
	$CrateDelivered_Label.text = String(ammount) 
	
func Get_CreateDelivered_Label()->int:
	return int($CrateDelivered_Label.text)

func On_StartChasingBar_Timeout():
	emit_signal("startChasingTimer_timeout")
	nextmissile_bar.Start_Timer()
	
func On_NextMissileBar_Timeout():
	emit_signal("nextMissileTimer_timeout")
