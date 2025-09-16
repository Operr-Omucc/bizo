extends Node2D


func _on_button_pressed() -> void:
	gamedata.reset_stat()
	gamedata.money_amount/=2
	gamedata.game_money=gamedata.money_amount
	gamedata.money_amount=0
	get_tree().change_scene_to_file("res://Escenas/main_menu.tscn")
