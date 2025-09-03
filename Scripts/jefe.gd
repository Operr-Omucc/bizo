extends 'res://Scripts/enemigo.gd'

func _ready():
	health = 1000
	speed = 90

func _physics_process(_delta: float) -> void:
	check_death()
	return

func check_death():
	if health<=1:
		gamedata.damage = 0 
		gamedata.speed = 0
		gamedata.armor = 0
		gamedata.chara_Scene = null
		gamedata.arm_scene = null
		gamedata.fire_rate = 0
		gamedata.rep = 0
		gamedata.currentWave=1
		gamedata.health = 0
		gamedata.maxHealth = 0
		gamedata.money_amount/=2
		gamedata.game_money=gamedata.money_amount
		gamedata.money_amount=0
		get_tree().change_scene_to_file("res://Escenas/victoria.tscn")
