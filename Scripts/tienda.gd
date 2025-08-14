extends Node2D
var personaje = preload("res://Personajes/personaje.tscn")
var mundo = preload("res://Escenas/mundo.tscn")
var reroll:int = 0
var mejora = mejora_path
var cooldown: bool = false
@onready var mejora_path= preload("res://Escenas/mejora.tscn")

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
<<<<<<< Updated upstream
	mejora.queue_free()
=======
	if mejora!=null:
		mejora.queue_free()
>>>>>>> Stashed changes
	get_tree().change_scene_to_file("res://Escenas/mundo.tscn")

func enfriamiento():
	while cooldown==false:
		_on_palanca_pressed()

func _on_palanca_pressed() -> void:
	var mejoras = get_tree().get_nodes_in_group("mejora")
	for m in mejoras:
		m.queue_free()
	
	reroll *= gamedata.currentWave
	if gamedata.money_amount >= reroll && cooldown==false:
<<<<<<< Updated upstream
=======
		gamedata.money_amount -= reroll
>>>>>>> Stashed changes
		cooldown=true
		for n in (3):
			mejora= mejora_path.instantiate()
			mejora.tipo_mejora = randi_range(1,2)
			get_parent().add_child(mejora)
			mejora.global_position= Vector2(230, 230)
			await get_tree().create_timer(1).timeout
<<<<<<< Updated upstream
=======
	elif gamedata.money_amount<reroll:
		$Label.text = "No tenes dinero pa jaja salu2"
		await get_tree().create_timer(5).timeout
		$Label.text = ""
>>>>>>> Stashed changes
		
	while cooldown==true:
		await get_tree().create_timer(4).timeout
		cooldown=false
<<<<<<< Updated upstream
	gamedata.money_amount -= reroll
=======
	
>>>>>>> Stashed changes
