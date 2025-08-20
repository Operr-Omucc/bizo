# Script en la torreta (Node2D o Area2D)
extends Node2D

@onready var proyectil_path = preload("res://Escenas/proyectil.tscn")
var fire_cooldown = 1.0
var fire_timer = 0.0

func _process(delta):
	fire_timer -= delta

func disparo():
	if fire_timer <= 0:
		var target = get_tree().get_nodes_in_group("personaje")[0]
		if target:
			look_at(target.global_position)  # Asegura que la torreta apunte
			var proy = proyectil_path.instantiate()
			proy.add_to_group("proyectil")
			proy.dir = rotation  # Asegúrate que el proyectil tenga esta propiedad
			proy.pos = global_position
			proy.rota = global_rotation
			get_tree().get_root().add_child.call_deferred(proy)
			fire_timer = fire_cooldown
