extends 'res://Scripts/enemigo.gd'

func _ready():
	health = 1000
	speed = 90

func _physics_process(_delta: float) -> void:
	check_death()
	return

func check_death():
	if health<=0:
		get_tree().change_scene_to_file("res://Escenas/victoria.tscn")
		gamedata.rep = 0
		gamedata.currentWave=1
		gamedata.money_amount/=2
		gamedata.game_money=gamedata.money_amount
		gamedata.money_amount=0
