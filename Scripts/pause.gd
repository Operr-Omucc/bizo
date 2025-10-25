extends Node2D
	

# Funcion que detecta un Input, si el evento es que se presiono ESC, se muestra el menu SI no esta ya en
# Escena, si llegara a estar en escena lo oculta
func _input(event: InputEvent):
	if event.is_action_pressed("Menu pausa"):
		if get_tree().paused == true:
			$CanvasLayer.visible = false
			get_tree().paused = false
			gamedata.pause = false
		else:
			get_tree().paused = true
			$CanvasLayer.visible = true
			gamedata.pause = true
			
# Funcion para volver al juego, solamente esconde el menu de pausa y despausa el juego
func _on_button_pressed() -> void:
		$CanvasLayer.visible = false
		get_tree().paused = false

# Funcion para volver al menu principal, quita la pausa, hace el menu de pausa invisible y te envia
# Al menu principal
func _on_button_2_pressed() -> void:
	ContinuarPartida.save_game()
	AudioManager.stop_tienda()
	$CanvasLayer.visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Escenas/main_menu.tscn")
