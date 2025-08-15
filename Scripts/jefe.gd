extends 'res://Scripts/enemigo.gd'

func _ready():
	health = 1000
	speed = 90

func _physics_process(_delta: float) -> void:
	check_death()

func disparar_mortadela():
	

func check_death():
	if health<=0:
		get_tree().change_scene_to_file("res://Escenas/main_menu.tscn")
		gamedata.currentWave=1
		gamedata.money_amount/=2
		gamedata.money_game=gamedata.money_amount
		gamedata.money_amount=0
