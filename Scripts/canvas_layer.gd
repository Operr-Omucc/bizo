extends CanvasLayer

var shots_fired: int = 6
var cooldown: bool = true

func _ready():
	if gamedata.chara_name == "John Cowboy":
		# actualizar GUI
		$Label2.text = "%s/6" % [shots_fired]
	else:
		return

func _physics_process(_delta: float) -> void:
	$Label.text = "Quedan %s Enemigos" % [gamedata.en-gamedata.rep]
	if gamedata.configStats==true:
		$PantallaBlanca/Label.text = "Daño: %s
		Velocidad: %s
		Vida: %s" % [gamedata.damage, gamedata.speed, gamedata.maxHealth]
	detect_shot()
	fire_shots()

func detect_shot():
	
	# si no es John Cowboy
	if gamedata.chara_name != "John Cowboy":
		return

	# si no quedan balas
	if shots_fired == 0:
		if is_inside_tree():
			await get_tree().create_timer(2).timeout
		shots_fired = 6
		
func fire_shots():
	# si quedan balas
	if shots_fired > 0  && Input.is_action_just_pressed("Disparo"):
		if not cooldown:
			return
		cooldown = false
		shots_fired -= 1
		$Label2.text = "%s/6" %[shots_fired]
		if is_inside_tree():
			await get_tree().create_timer(0.3).timeout
		cooldown = true
