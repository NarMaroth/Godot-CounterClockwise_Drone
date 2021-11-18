extends Sprite


onready var animPlayer = $AnimationPlayer


func set_variant(variant:int):
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
			
