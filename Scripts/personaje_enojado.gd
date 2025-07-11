extends 'res://Scripts/personaje.gd'

func _ready():
	maxHealth = 200
	health = 200
	speed = 350
	self.add_to_group("personaje")
