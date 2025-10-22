extends 'res://Scripts/enemigo.gd'

# Se establece la vida del jefe
func _ready():
	health = 3000

func _physics_process(_delta: float) -> void:
	# Revisa si el jefe murio
	check_death()

func check_death():
	if health<=1:
		# Si el jefe muere las stats se resetean, el dinero se parte a la mitad y se establece como
		# money_amount, que es basicamente el dinero que podes usar para comprar personajes, tambien
		# se reinicia la cantidad de dinero que tenes
		gamedata.reset_stat()
		gamedata.money_amount/=2
		gamedata.game_money=gamedata.money_amount
		gamedata.money_amount=0
		get_tree().change_scene_to_file("res://Escenas/victoria.tscn")
	else:
		return
