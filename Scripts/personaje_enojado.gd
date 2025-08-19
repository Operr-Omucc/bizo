extends 'res://Scripts/personaje.gd'

func _ready():
	maxHealth = gamedata.maxHealth
	health = gamedata.health
	speed = gamedata.speed+350
	self.add_to_group("personaje")
