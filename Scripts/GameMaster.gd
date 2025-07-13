extends Node2D
var enemigo = preload("res://Escenas/enemigo.tscn").instantiate()
var arma = preload("res://Escenas/arma.tscn").instantiate()

func _ready():
	#Spawnea todo adentro del mundo
	
	var personaje = gamedata.chara_Scene.instantiate()
	add_child(personaje)
	personaje.global_position = Vector2(100, 100)

	# Añade arma al personaje
	personaje.add_child(arma)
	arma.position = Vector2(120.0, 30.0)

	# Añade enemigo
	add_child(enemigo)
	enemigo.global_position = Vector2(856.0, -95.0)
	enemigo.target = personaje


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Escenas/tienda.tscn")
