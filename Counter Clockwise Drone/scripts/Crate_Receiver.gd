extends Area2D

signal create_received


onready var animPlayer = $AnimationPlayer


func set_sprite(variant:int):
	match variant:
		0:
			animPlayer.play("Crate_00")
		1:
			animPlayer.play("Crate_01")
		2:
			animPlayer.play("Crate_02")
		3:
			animPlayer.play("Crate_03")
		4:
			animPlayer.play("Crate_04")

func _on_Create_Receiver_body_entered(body):
	if(body.transporting_create == true):
		body.transporting_create = false
		emit_signal("create_received")
		queue_free()


