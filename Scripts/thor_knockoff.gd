extends 'res://Scripts/personaje.gd'

func _ready():
	animation_player.play("Quieto")
	maxHealth = gamedata.maxHealth
	health = gamedata.health
	if gamedata.currentWave == 1:
		gamedata.speed=+700
	self.add_to_group("personaje")
	speed = gamedata.speed
