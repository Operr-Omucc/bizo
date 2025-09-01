extends Node2D

func _ready() -> void:
	AudioManager.play_derrota()

func _on_button_pressed() -> void:
	gamedata.damage = 0
	get_tree().change_scene_to_file("res://Escenas/main_menu.tscn")
