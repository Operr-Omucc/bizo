extends Node2D
var personaje = preload("res://Personajes/personaje.tscn")
var mundo = preload("res://Escenas/mundo.tscn")
var reroll:int = 3
var mejora = mejora_path
@onready var mejora_path= preload("res://Escenas/mejora.tscn")

func _physics_process(_delta: float) -> void:
	gamedata.debug()

func _ready() -> void:
	gamedata.zona = false
	ContinuarPartida.save_game()
	$Label.add_theme_color_override("font_color", Color.BLACK)
	actualizarTextoTirada()
	
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
	
	reroll *= gamedata.currentWave
	if gamedata.money_amount >= reroll:
		actualizarTextoRico()
		gamedata.money_amount -= reroll
		for n in (3):
			mejora= mejora_path.instantiate()
			mejora.tipo_mejora = randi_range(1,92)
			get_parent().add_child(mejora)
			mejora.global_position= Vector2(496, 112)
			await get_tree().create_timer(1).timeout
		actualizarTextoTirada()
	elif gamedata.money_amount<reroll:
		actualizarTextoPobre()
		await get_tree().create_timer(5).timeout
		actualizarTextoTirada()
	
	
	
func actualizarTextoTirada():
	$Label.visible_characters = 0
	$Label.text = "Tenes %s dinero,
	gastalo bien, la tirada cuesta %s" % [gamedata.money_amount, reroll]
	$Palanca.disabled = true
	for i in range($Label.text.length()):
		var character = $Label.text[i]
		
		$Label.visible_characters += 1
		await get_tree().create_timer(0.1).timeout
		
		if character.is_valid_identifier():
			AudioManager.play_hombreTienda()
	$Palanca.disabled = false
	
func actualizarTextoPobre():
	$Palanca.disabled = true
	$Label.visible_characters = 0
	$Label.text = "No tenes dinero pa jaja salu2"
	for i in $Label.text.length():
		var character = $Label.text[i]
		
		$Label.visible_characters += 1
		await get_tree().create_timer(0.1).timeout
		
		if character.is_valid_identifier():
			AudioManager.play_hombreTienda()
			
func actualizarTextoRico():
	$Palanca.disabled = true
	$Label.visible_characters = 0
	$Label.text = "Nice"
	for i in $Label.text.length():
		var character = $Label.text[i]
		
		$Label.visible_characters += 1
		await get_tree().create_timer(0.1).timeout
		
		if character.is_valid_identifier():
			AudioManager.play_hombreTienda()
