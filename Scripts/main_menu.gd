extends Node2D


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/seleccion_per.tscn")


func _on_button_2_pressed() -> void:
	get_tree().quit()
	
	
func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/opciones.tscn")
