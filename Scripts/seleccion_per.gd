extends Node2D
var chosen_Character
var characters = {
	1: {
		"maxHealth": 100,
		"scene": preload("res://Personajes/personaje.tscn"),
		"arm": preload("res://Escenas/brazo.tscn"),
		"gun": preload("res://Escenas/arma.tscn"),
	},
	2: {
		"maxHealth": 200,
		"scene": preload("res://Personajes/personaje_enojado.tscn"),
		"arm": preload("res://Escenas/brazo.tscn"),
		"gun": preload("res://Escenas/arma.tscn"),
	},
	3: {
		"maxHealth": 90,
		"scene": preload("res://Personajes/john_cowboy.tscn"),
		"gun": preload("res://Escenas/revolver.tscn"),
	},
	4: {
		"maxHealth": 150,
		"scene": preload("res://Personajes/bob_puñolimpio.tscn"),
		"gun": preload("res://Escenas/brazo.tscn"),
		"arm": preload ("res://Escenas/brazo.tscn"),
		"cost": 20, 
		"unlocked": false,
		"conditions": []
	}
}


#funcion que envia dificultad al mundo
func dificultad():
	get_tree().change_scene_to_file("res://Escenas/dificultad.tscn")

func _ready() -> void:
	$popup.visible = false
#de acá para abajo las funciones van a dedicarse a settear escena_personaje a un personaje

func _on_button_pressed() -> void:
	$popup/Personaje1.visible = true
	chosen_Character = 1

func _on_button_2_pressed() -> void:
	$popup/Personaje2.visible = true
	chosen_Character = 2

func _on_button_3_pressed() -> void:
	$popup/Personaje3.visible = true
	chosen_Character = 3
	
func _on_button_4_pressed() -> void:
	$popup/Personaje4.visible = true
	chosen_Character = 4
	
func _on_iniciar_juego_pressed() -> void:
	if chosen_Character in characters:
		var chara = characters[chosen_Character]
		gamedata.maxHealth = chara["maxHealth"]
		gamedata.health = chara["maxHealth"]
		gamedata.chara_Scene = chara["scene"]
		if chara.has("arm"):
			gamedata.arm_scene = chara["arm"]
		if chara.has("gun"):
			gamedata.gun_scene = chara["gun"]
	dificultad()

func _on_x_pressed() -> void:
	$popup.visible = false
	for child in $popup.get_children():
		if child is CanvasLayer:  # Sprite, Button, Label, etc.
			child.visible = false

func _on_bloq_pj_1_pressed() -> void:
	if gamedata.money_amount >= 20:
		gamedata.money_amount -= 20
		$bloq_pj/bloq_pj1.visible = false

func try_unlock(character_name: String) -> void:
	var char_data = characters[character_name]
	if char_data["unlocked"]:
		return # ya desbloqueado
		
	 # chequear condiciones especiales
	for cond in char_data["conditions"]:
		if not check_condition(cond):
			print("No puedes desbloquear aún:", cond)
			return

		# chequear dinero
	if gamedata.money_amount >= char_data["cost"]:
		gamedata.money_amount -= char_data["cost"]
		char_data["unlocked"] = true
		update_character_ui(character_name)
		print(character_name, "desbloqueado!")
	else:
		print("No tienes suficiente dinero")

func update_character_ui(name: String):
	$bloq_pj.get_node("bloq_" + name).visible = false #ACTUALIZA UI PARA DESBLOQUEAR PERSONAJE
	
func check_condition(cond: String) -> bool:
	match cond: #REVISA CONDICIONES PARA DESBLOQUEO DE PERSONAJES
		"pj1_unlocked":
			return characters["pj1"]["unlocked"]
		"win_with_all":
			return gamedata.all_characters_won
		_:
			return false
