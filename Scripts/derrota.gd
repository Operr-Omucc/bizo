extends Node2D


func _on_button_pressed() -> void:
	gamedata.rep = 0
	gamedata.currentWave=1
	gamedata.gun_scene = null
	gamedata.arm_scene = null
	gamedata.money_amount/=2
	gamedata.game_money=gamedata.money_amount
	gamedata.money_amount=0
	gamedata.fire_rate = 1
	gamedata.damage = 0
	get_tree().change_scene_to_file("res://Escenas/main_menu.tscn")
