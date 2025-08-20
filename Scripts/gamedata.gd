extends Node

#Maneja cosas como el personaje seleccionado
var chara_Scene : PackedScene
var arm_scene : PackedScene
var gun_scene : PackedScene
var game_money : int # Dinero recolectado por el jugador, se mantiene entre partidas USADO SOLO PARA COMPRAR PERSONAJES O COSAS EN EL MENU
var money_amount : int # Dinero recolectado por el jugador, solo existe dentro de la partida USADO SOLO PARA COMPRAR MEJORAS DENTRO DE LA PARTIDA
var maxHealth: int = 0
var health: int = 0
var damage: int
var speed: int
#var fire_rate: int = gun_scene.fire_rate


@export var currentWave: int
var rep: int
var dif: int

func _ready():
	currentWave = 1
	
func enemy_damage():
	var base_damage = 5
	var scaling_factor = 1.15
	return base_damage * pow(scaling_factor, currentWave) * dif
