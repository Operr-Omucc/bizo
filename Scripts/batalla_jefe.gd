extends Node2D

var personaje = gamedata.chara_Scene.instantiate()
var arma =safe_instance(gamedata.gun_scene)
var brazo = safe_instance(gamedata.arm_scene)
var wave_dif = gamedata.currentWave+2
var dif = gamedata.dif

func _ready():
	#Spawnea todo adentro del mundo
	
	add_child(personaje)
	personaje.global_position = Vector2(-6592,-384)

	# Añade arma al personaje
	if arma!=null:
		personaje.add_child(arma)
		arma.position = Vector2(120.0, 30.0)
	if brazo!=null:
		personaje.add_child(brazo)
		arma.position = Vector2(120.0, 30.0)

func safe_instance(scene: PackedScene) -> Node: #funcion que permite aparecer escenas que son nulas
	if scene != null:
		return scene.instantiate()
	return null
