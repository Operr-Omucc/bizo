extends Node2D
#funcion que envia al mundo
func dificultad():
	get_tree().change_scene_to_file("res://Escenas/dificultad.tscn")


#de acá para abajo las funciones van a dedicarse a settear escena_personaje a un personaje

func _on_button_pressed() -> void:
	gamedata.maxHealth=100
	gamedata.health=100
	gamedata.chara_Scene = preload('res://Personajes/personaje.tscn')
	gamedata.arm_scene = preload("res://Escenas/brazo.tscn")
	gamedata.gun_scene = preload("res://Escenas/arma.tscn")
	dificultad()


func _on_button_2_pressed() -> void:
	gamedata.maxHealth=200
	gamedata.health=200
	gamedata.chara_Scene = preload('res://Personajes/personaje_enojado.tscn')
	gamedata.arm_scene = preload("res://Escenas/brazo.tscn")
	gamedata.gun_scene = preload("res://Escenas/arma.tscn")
	dificultad()


func _on_button_3_pressed() -> void:
	gamedata.maxHealth=90
	gamedata.health=90
	gamedata.chara_Scene = preload('res://Personajes/john_cowboy.tscn')
	gamedata.gun_scene = preload("res://Escenas/revolver.tscn")
	dificultad()
