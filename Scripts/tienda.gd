extends Node2D
var personaje = preload("res://Personajes/personaje.tscn")
var mundo = preload("res://Escenas/mundo.tscn")
var reroll:int = 3
var mejora = mejora_path
@onready var mejora_path= preload("res://Escenas/mejora.tscn")

func _ready() -> void:
	$Label.add_theme_color_override("font_color", Color.BLACK)
	$Label.text = "Tenes %s dinero, gastalo bien 
	la tirada cuesta %s" % [gamedata.money_amount, reroll]	

func _on_button_3_pressed() -> void:
	gamedata.currentWave += 1 
	gamedata.rep = 0
	if mejora!=null:
		mejora.queue_free()
	if gamedata.currentWave == 20:
		get_tree().change_scene_to_file("res://Escenas/batalla_jefe.tscn")
	elif gamedata.currentWave < 20:
		get_tree().change_scene_to_file("res://Escenas/mundo.tscn")

func _on_palanca_pressed() -> void:
	$Palanca.disabled = true
	var mejoras = get_tree().get_nodes_in_group("mejora")
	for m in mejoras:
		m.queue_free()
	
	reroll *= gamedata.currentWave
	if gamedata.money_amount >= reroll:
		gamedata.money_amount -= reroll
		$Palanca.icon 
		for n in (3):
			mejora= mejora_path.instantiate()
			mejora.tipo_mejora = randi_range(1,100)
			get_parent().add_child(mejora)
			mejora.global_position= Vector2(496, 112)
			await get_tree().create_timer(1).timeout
	elif gamedata.money_amount<reroll:
		$Label.text = "No tenes dinero pa jaja salu2"
		await get_tree().create_timer(5).timeout
		$Label.text = "Tenes %s dinero, gastalo bien, la tirada cuesta %s" % [gamedata.money_amount, reroll]	
	$Palanca.disabled = false
