extends Node

#Maneja cosas como el personaje seleccionado
var chara_Scene : PackedScene
var money_amount : int
var maxHealth: int = 0
var health: int = 0
var currentWave: int = 1
var dif: int

func enemy_damage():
	var base_damage = 5
	var scaling_factor = 1.15
	return base_damage * pow(scaling_factor, currentWave)
