extends CanvasLayer

func _physics_process(delta: float) -> void:
	$Label.text = "Quedan %s Enemigos" % [gamedata.en-gamedata.rep]
	if gamedata.configStats==true:
		$PantallaBlanca/Label.text = "Daño: %s
		Velocidad: %s
		Vida: %s" % [gamedata.damage, gamedata.speed, gamedata.maxHealth]
