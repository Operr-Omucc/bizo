extends Node2D

func mundo():
	get_tree().change_scene_to_file("res://Escenas/mundo.tscn")
	
func _on_button_pressed() -> void:
	gamedata.dif = 1 #facil
	mundo()

func _on_button_2_pressed() -> void:
	gamedata.dif = 3 #dificil
	mundo()

func _on_button_3_pressed() -> void:
	gamedata.dif = 2 #normal
	mundo()

func _on_button_4_pressed() -> void:
	gamedata.dif = 10 #imposible
	mundo()

func _on_button_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/seleccion_per.tscn")
