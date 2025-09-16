extends Node2D

func _ready() -> void:
	AudioManager.play_derrota()

func _on_button_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Escenas/main_menu.tscn")
