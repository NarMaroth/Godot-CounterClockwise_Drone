extends ProgressBar

signal timeout_signal

onready var timer = $NextMissile_Timer
var timer_active : bool

func _ready():
	visible = false
	timer_active = false
	max_value = timer.wait_time

func _process(delta):
	if (timer_active) :
		value = timer.time_left

func Restart_Timer():
	timer.start()

func Start_Timer():
	timer_active = true
	visible = true
	timer.start()
	
func Stop_Timer():
	timer_active = false
	visible = false
	timer.stop()


func _on_NextMissile_Timer_timeout():
	emit_signal("timeout_signal")
