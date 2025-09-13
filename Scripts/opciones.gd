extends Node2D
func _ready() -> void:
	$Label2.visible = false

func _physics_process(delta: float) -> void:
	gamedata.debug()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/main_menu.tscn")


func _on_button_2_pressed() -> void:
	if gamedata.configStats == true:
		gamedata.configStats = false
	else:
		gamedata.configStats = true
	$Label2.visible = true
	if self.is_inside_tree():
		await get_tree().create_timer(2).timeout
	$Label2.visible = false
