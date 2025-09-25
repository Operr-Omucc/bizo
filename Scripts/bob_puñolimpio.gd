extends "res://Scripts/personaje.gd"
var damage: int

func _ready() -> void:
	animation_player.play("Quieto")
	health = 150
	maxHealth = 150
	if gamedata.currentWave == 1:
		gamedata.speed=+600
	self.add_to_group("personaje")
	speed = gamedata.speed
