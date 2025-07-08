extends Node2D

func _ready():
	var personaje = gamedata.escena_personaje.instantiate()
	add_child(personaje)
	personaje.global_position = Vector2(100, 100)

	var arma = preload("res://Escenas/arma.tscn").instantiate()
	personaje.add_child(arma)
	arma.position = Vector2(120.0, 30.0)

	var enemigo = preload("res://Escenas/enemigo.tscn").instantiate()
	add_child(enemigo)
	enemigo.global_position = Vector2(856.0, -95.0)
	enemigo.target = personaje  # ← asignás el target directamente
