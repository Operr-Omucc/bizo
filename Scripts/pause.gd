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
	gamedata.damage = 0 
	gamedata.speed = 0
	gamedata.armor = 0
	gamedata.chara_Scene = null
	gamedata.arm_scene = null
	gamedata.fire_rate = 0
	gamedata.rep = 0
	gamedata.currentWave=1
	gamedata.health = 0
	gamedata.maxHealth = 0
	gamedata.money_amount/=2
	gamedata.game_money=gamedata.money_amount
	gamedata.money_amount=0
	get_tree().change_scene_to_file("res://Escenas/main_menu.tscn")
