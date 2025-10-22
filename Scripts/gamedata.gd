extends Node

# Escenas relevantes al jugador
var chara_Scene : PackedScene
var arm_scene : PackedScene
var gun_scene : PackedScene

# Variables relevantes a la cantidad de dinero del jugador, game_money = moneda dentro de partida
# money_amount = moneda que se conserva entre partidas, usada para comprar personajes
var game_money : int 
var money_amount : int 

# Variables relevantes a las estadisticas del jugador
var maxHealth: int = 0
var health: int = 0
var damage: int
var speed: int = 0
var fire_rate: float = 1
var armor : int
var chara_name

# Variables relevantes a cosas miscelaneas, como si el juego esta en pausa, que zona esta el jugador (tienda o mundo)
# La visibilidad de las estadisticas (configStats) y si paso a travez del tutorial o no
var pause : bool = true
var zona : bool
var configStats : bool
var tuto: bool = false

# Variables relevantes a las oleadas, en que oleada esta el jugador, que cantidad de enemigos mato y
# Que dificultad selecciono y la cantidad de enemigos en la oleada (variable en)
@export var currentWave: int
var rep: int
var dif: int
var en

func _ready():
	# Cuando se inicia el juego se establecen las estadisticas por defecto en prendido y la oleada
	# A la primera
	currentWave = 1
	configStats = true
	
# Funcion que calcula el daño del enemigo basandonos en la dificultad, oleada actual y armadura del jugador
func enemy_damage():
	var base_damage = 5
	var scaling_factor = 1.15
	return base_damage * pow(scaling_factor, currentWave) * dif - armor

# Funcion que reseta las estadisticas del jugador, usada en otros scripts cuando el jugador pierda
# O gana
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

# Una variable usada para almacenar los datos de los personajes, que armas usan, se usa en otros scripts
# Para verificar al personaje seleccionado
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
		"character_name": "Reimu Hakurei",
		"maxHealth": 50,
		"scene": preload("res://Personajes/reimu.tscn"),
		"gun": preload("res://Escenas/varita_reimu.tscn"),
		"arm":  preload ("res://Escenas/brazo.tscn"),
		"cost": 0,
		"unlocked": false
	}
}


# Funcion de debug, añade mecanicas para facilitar el testeo del juego, como daño "infinito",
# Vida "infinita", una cantidad absurda de monedas o para llevarte al a batalla contra el jefe
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
