extends CanvasLayer

var reloading = false
var shots_fired: int = 6
var cooldown: bool = true

func _ready():
	if gamedata.chara_name == "John Cowboy":
		# actualizar GUI
		$PantallaBlanca3/Label2.text = "%s/6" % [shots_fired]
	else:
		$PantallaBlanca3.visible = false
		
	if gamedata.chara_name == "Reimu Hakurei":
		$Disparo1.visible=false
		$Disparo2.visible=true
	else:
		$Disparo1.visible=false
		pass

func _physics_process(_delta: float) -> void:
	$PantallaBlanca2/Label.text = "Quedan %s Enemigos" % [gamedata.en-gamedata.rep]
	if gamedata.configStats==true:
		$PantallaBlanca/Label.text = "Daño: %s
		Velocidad: %s
		Vida: %s" % [gamedata.damage, gamedata.speed, gamedata.maxHealth]
	if gamedata.chara_name == "John Cowboy":
		detect_shot()
	elif gamedata.chara_name == "Reimu Hakurei":
		detectSkill()
	else:
		return

func detect_shot():
	if gamedata.chara_name != "John Cowboy":
		return
	
	# si todavía hay balas y no estás recargando
	if shots_fired > 0 && !reloading:
		if Input.is_action_just_pressed("Disparo"):
			shots_fired -= 1
			$PantallaBlanca3/Label2.text = "%s/6" % [shots_fired]
	
	# si te quedaste sin balas y no estás recargando
	elif shots_fired == 0 && !reloading:
		reloading = true
		if is_inside_tree():
			await get_tree().create_timer(2).timeout
		shots_fired = 6
		reloading = false
		$PantallaBlanca3/Label2.text = "%s/6" % [shots_fired]

func detectSkill():
	if gamedata.chara_name == "Reimu Hakurei":
		if Input.is_action_just_pressed("Dash") && $Disparo2.visible==true:
			$Disparo1.visible = true
			$Disparo2.visible = false
		elif Input.is_action_just_pressed("Dash") && $Disparo2.visible==false:
			$Disparo1.visible = false
			$Disparo2.visible = true
	else:
		return
