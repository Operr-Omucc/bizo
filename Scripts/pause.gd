extends Node2D
	
func _input(event: InputEvent):
	if event.is_action_pressed("Menu pausa"):
		if get_tree().paused == true:
			$CanvasLayer.visible = false
			get_tree().paused = false
		else:
			get_tree().paused = true
			$CanvasLayer.visible = true
			
func _on_button_pressed() -> void:
		$CanvasLayer.visible = false
		get_tree().paused = false


func _on_button_2_pressed() -> void:
	$CanvasLayer.visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Escenas/main_menu.tscn")
