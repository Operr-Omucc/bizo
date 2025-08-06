extends Node2D

var arma = preload("res://Escenas/arma.tscn").instantiate()
var brazo = preload("res://Escenas/brazo.tscn").instantiate()
var wave_dif = gamedata.currentWave+2

func _ready():
	
	#Spawnea todo adentro del mundo
	
	var personaje = gamedata.chara_Scene.instantiate()
	add_child(personaje)
	personaje.global_position = Vector2(896, 704)

	# Añade arma al personaje
	personaje.add_child(arma)
	arma.position = Vector2(120.0, 30.0)
	
	personaje.add_child(brazo)
	arma.position = Vector2(120.0, 30.0)

	# Añade enemigo
	for n in (wave_dif * 2):
		var enemigo = preload("res://Escenas/enemigo.tscn").instantiate()
		add_child(enemigo)
		enemigo.global_position = Vector2(randi_range(608, 2560), randi_range(16, 2704))
		enemigo.target = personaje


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Escenas/tienda.tscn")
