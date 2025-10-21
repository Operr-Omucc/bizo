extends Node2D

# Funcion para detener la musica del juego
func _ready():
	AudioManager.stop_juego()

# Aplicacion de la funcion de debug de gamedata
func _physics_process(_delta: float) -> void:
	gamedata.debug()

# Boton que envia a seleccionar un personaje
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/seleccion_per.tscn")

# funcion para salir del juego (estas funciones estan muy mal ordenadas xd)
func _on_button_2_pressed() -> void:
	get_tree().quit()
	
# Funcion para enviar al jugador a las opciones
func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/opciones.tscn")

# Funcion para enviar al jugador a la pantalla de creditos
func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/creditos.tscn")

# Funcion para continuar partida, si es que se empezo una partida, si estuvo en una zona empieza 
# En la oleada que el jugador salio del juego, si estuvo en la tienda empieza desde la tienda y si
# No empezo la partida entonces envia a la pantalla de seleccion de personaje
func _on_button_5_pressed() -> void:
	ContinuarPartida.load_game()
	if ContinuarPartida.game_data.has("personaje") and ContinuarPartida.game_data["personaje"] != null:
		if gamedata.zona == true:
			get_tree().change_scene_to_file("res://Escenas/mundo.tscn")
		else:
			get_tree().change_scene_to_file("res://Escenas/tienda.tscn")
	else:
		get_tree().change_scene_to_file("res://Escenas/seleccion_per.tscn")
