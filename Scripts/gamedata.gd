extends Node

#Maneja cosas como el personaje seleccionado y sus stats
var chara_Scene : PackedScene
var arm_scene : PackedScene
var gun_scene : PackedScene
var game_money : int # Dinero recolectado por el jugador, se mantiene entre partidas USADO SOLO PARA COMPRAR PERSONAJES O COSAS EN EL MENU
var money_amount : int # Dinero recolectado por el jugador, solo existe dentro de la partida USADO SOLO PARA COMPRAR MEJORAS DENTRO DE LA PARTIDA
var maxHealth: int = 0
var health: int = 0
var damage: int
var speed: int = 0
var fire_rate: int = 1
var armor : int
var configStats : bool
var chara_name
var pause : bool = true
var zona : bool

@export var currentWave: int
var rep: int
var dif: int

var en

func _ready():
	currentWave = 1
	configStats = true
	
func enemy_damage():
	var base_damage = 5
	var scaling_factor = 1.15
	return base_damage * pow(scaling_factor, currentWave) * dif - armor


func reset_stat():
	fire_rate = 0
	damage = 0 
	speed = 0
	armor = 0
	chara_Scene = null
	arm_scene = null
	fire_rate = 1
	rep = 0
	currentWave=1
	health = 0
	maxHealth = 0

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
		"gun": preload("res://Escenas/escopeta.tscn"),
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
		"gun": null,
		"arm": preload("res://Escenas/martillothor.tscn"),
		"cost": 0,
		"unlocked": false,
		"conditions": ["wingame"]
	},
	6: {
		"character_name": "thor knockoff",
		"maxHealth": 350,
		"scene": preload("res://Personajes/reimu.tscn"),
		"gun": preload("res://Escenas/varita_reimu.tscn"),
		"arm":  preload ("res://Escenas/brazo.tscn"),
		"cost": 0,
		"unlocked": false
	}
}

func debug():
	if Input.is_action_just_pressed("Debug daño"):
		gamedata.damage=999999
	if Input.is_action_just_pressed("Debug vida"):
		gamedata.health=999999
		gamedata.maxHealth=999999
	if Input.is_action_just_pressed("Debug dinero"):
		gamedata.money_amount=999999
		gamedata.game_money=999999
	if Input.is_action_just_pressed("Debug jefe"):
		get_tree().change_scene_to_file("res://Escenas/batalla_jefe.tscn")
	else:
		return
