extends Node2D


func _physics_process(_delta: float) -> void:
	gamedata.debug()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/seleccion_per.tscn")


func _on_button_2_pressed() -> void:
	get_tree().quit()
	
	
func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/opciones.tscn")


func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/creditos.tscn")


func _on_button_5_pressed() -> void:
	ContinuarPartida.load_game()
	if ContinuarPartida.game_data.has("personaje") and ContinuarPartida.game_data["personaje"] != null:
		if gamedata.zona == true:
			get_tree().change_scene_to_file("res://Escenas/mundo.tscn")
		else:
			get_tree().change_scene_to_file("res://Escenas/tienda.tscn")
	else:
		get_tree().change_scene_to_file("res://Escenas/seleccion_per.tscn")
