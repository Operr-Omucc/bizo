extends 'res://Scripts/personaje.gd'

func _ready():
	maxHealth = gamedata.maxHealth
	health = gamedata.health
	speed = gamedata.speed+700
	self.add_to_group("personaje")
