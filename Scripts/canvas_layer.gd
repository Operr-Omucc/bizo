extends CanvasLayer

func _physics_process(delta: float) -> void:
	$Label.text = "Quedan %s Enemigos" % [gamedata.en-gamedata.rep]
