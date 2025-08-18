extends "res://Scripts/personaje.gd"
var damage: int

func _ready() -> void:
	health = 150
	maxHealth = 150
	speed = 600
	self.add_to_group("personaje")
	await get_tree().create_timer(0.2).timeout
	damage = 40
