extends Node2D
#funcion que envia al mundo
func mundo():
	get_tree().change_scene_to_file("res://Escenas/mundo.tscn")


#de acá para abajo las funciones van a dedicarse a settear escena_personaje a un personaje

func _on_button_pressed() -> void:
	gamedata.chara_Scene = preload('res://Personajes/personaje.tscn')
	mundo()


func _on_button_2_pressed() -> void:
	gamedata.chara_Scene = preload('res://Personajes/personaje_enojado.tscn')
	mundo()
