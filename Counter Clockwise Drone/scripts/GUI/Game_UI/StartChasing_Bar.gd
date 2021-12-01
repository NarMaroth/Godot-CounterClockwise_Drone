extends ProgressBar

signal timeout_signal

onready var timer = $StartChasing_Timer
var timer_active : bool

func _ready():
	timer_active = false
	max_value = timer.wait_time

func _process(delta):
	if (timer_active) :
		value = timer.time_left

func Restart_Timer():
	timer.start()

func Start_Timer():
	timer_active = true
	timer.start()
	
func Stop_Timer():
	timer_active = false
	timer.stop()


func _on_StartChasing_Timer_timeout():
	emit_signal("timeout_signal")
