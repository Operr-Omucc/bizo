extends Node2D

# Pone una label de la configuracion como invisible, se mostrara mas tarde
func _ready() -> void:
	$Label2.visible = false

# Funcion para el debug
func _physics_process(_delta: float) -> void:
	gamedata.debug()

# Funcion para cambiar de escena a menu principal si se presiona el boton
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/main_menu.tscn")

# Funcion para saber si los stats se muestran o no, empieza verificando si la opcion esta prendida
# Si no lo esta entonces la prende, si esta, la apaga, luego hace la label visible para que el
# Jugador sepa que algo cambio y al segundo desaparece
func _on_button_2_pressed() -> void:
	if gamedata.configStats == true:
		gamedata.configStats = false
	else:
		gamedata.configStats = true
	$Label2.visible = true
	if self.is_inside_tree():
		await get_tree().create_timer(1).timeout
	$Label2.visible = false

# Lo mismo que el boton anterior pero con el audio xd
func _on_button_3_pressed() -> void:
	if AudioManager.mute == true:
		AudioManager.mute = false
	else:
		AudioManager.mute = true
	
	$Label2.visible = true
	if self.is_inside_tree():
		await get_tree().create_timer(1).timeout
	$Label2.visible = false
