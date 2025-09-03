extends Node2D

var tuto_pressed: bool

func mundo():
	get_tree().change_scene_to_file("res://Escenas/mundo.tscn")
	
func tuto():
	tuto_pressed = true
	get_tree().change_scene_to_file("res://Escenas/tutorial.tscn")
	
func _on_button_pressed() -> void:
	gamedata.dif = 1 #facil
	if tuto_pressed == true:
		mundo()
	else:
		tuto()

func _on_button_2_pressed() -> void:
	gamedata.dif = 3 #dificil
	if tuto_pressed == true:
		mundo()
	else:
		tuto()

func _on_button_3_pressed() -> void:
	gamedata.dif = 2 #normal
	if tuto_pressed == true:
		mundo()
	else:
		tuto()

func _on_button_4_pressed() -> void:
	gamedata.dif = 10 #imposible
	if tuto_pressed == true:
		mundo()
	else:
		tuto()

func _on_button_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/seleccion_per.tscn")


func _on_button_6_pressed() -> void:
	gamedata.dif = 15 #imposible
	gamedata.currentWave = 15
	tuto()
