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
var fire_rate: int = 1
var armor : int

@export var currentWave: int
var rep: int
var dif: int

func _ready():
	currentWave = 1
	
func enemy_damage():
	var base_damage = 5
	var scaling_factor = 1.15
	return base_damage * pow(scaling_factor, currentWave) * dif - armor
	if base_damage < 0:
		base_damage = 2

var characters = {
	1: {
		"character_name": "Bob",
		"maxHealth": 100,
		"scene": preload("res://Personajes/personaje.tscn"),
		"arm": preload("res://Escenas/brazo.tscn"),
		"gun": preload("res://Escenas/arma.tscn"),
	},
	2: {
		"character_name": "Bob Enojado",
		"maxHealth": 200,
		"scene": preload("res://Personajes/personaje_enojado.tscn"),
		"arm": preload("res://Escenas/brazo.tscn"),
		"gun": preload("res://Escenas/arma.tscn"),
	},
	3: {
		"character_name": "John Cowboy",
		"maxHealth": 90,
		"scene": preload("res://Personajes/john_cowboy.tscn"),
		"gun": preload("res://Escenas/revolver.tscn"),
	},
	4: {
		"character_name": "Bob Puñolimpio",
		"maxHealth": 150,
		"scene": preload("res://Personajes/bob_puñolimpio.tscn"),
		"gun": preload("res://Escenas/brazo.tscn"),
		"arm": preload ("res://Escenas/brazo.tscn"),
		"cost": 20, 
		"unlocked": false,
		"conditions": []
	},
	5: {
		"character_name": "thor knockoff",
		"maxHealth": 350,
		"scene": preload("res://Personajes/thor_knockoff.tscn"),
		"arm": preload("res://Escenas/martillothor.tscn"),
		"cost": 0,
		"unlocked": false,
		"conditions": ["wingame"]
	}
}
