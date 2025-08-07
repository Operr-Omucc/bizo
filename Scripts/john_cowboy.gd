extends 'res://Scripts/personaje.gd'

func _ready():
	maxHealth = gamedata.maxHealth
	health = gamedata.health
	speed = 600
	self.add_to_group("personaje")
