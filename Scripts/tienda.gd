extends Node2D
var personaje = preload("res://Personajes/personaje.tscn")
var mundo = preload("res://Escenas/mundo.tscn")

func _on_button_pressed() -> void:
	if gamedata.money_amount >= 9:
		gamedata.money_amount -= 9
		var extraHealth = 100
		gamedata.maxHealth += extraHealth

func _on_button_2_pressed() -> void:
	if gamedata.money_amount >= 5:
		gamedata.money_amount -= 5
		var shield = 50
		gamedata.health += shield

func _on_button_3_pressed() -> void:
	gamedata.currentWave += 1 
	get_tree().change_scene_to_file("res://Escenas/mundo.tscn")
