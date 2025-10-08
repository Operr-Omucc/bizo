extends Node2D
var personaje = preload("res://Personajes/personaje.tscn")
var mundo = preload("res://Escenas/mundo.tscn")
var reroll:int = 3
var mejora = mejora_path
@onready var mejora_path= preload("res://Escenas/mejora.tscn")
var dialogo_tienda : int
var precio : int

func _physics_process(_delta: float) -> void:
	gamedata.debug()

func _ready() -> void:
	precio = reroll * gamedata.currentWave
	AudioManager.stop_juego()
	AudioManager.play_tienda()
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
	dialogo_tienda = randi() % 100
	
	if gamedata.money_amount >= precio:
		actualizarTextoRico()
		gamedata.money_amount -= precio
		for n in (3):
			mejora= mejora_path.instantiate()
			mejora.tipo_mejora = randi_range(1,92)
			get_parent().add_child(mejora)
			mejora.global_position= Vector2(262, 72)
			await get_tree().create_timer(1).timeout
		actualizarTextoTirada()
	elif gamedata.money_amount<precio:
		actualizarTextoPobre()
		await get_tree().create_timer(5).timeout
		actualizarTextoTirada()
	
	
	
func actualizarTextoTirada():
	$Tienda1.texture = load("res://Sprites/tienda1.jpeg")
	$Label.visible_characters = 0
	if dialogo_tienda < 50:
		$Label.text = "Tenes %s dinero,
		gastalo bien, la tirada cuesta %s" % [gamedata.money_amount, precio]
	elif dialogo_tienda >= 50 && dialogo_tienda < 80:
		$Label.text = "no quiero arreglar 
		la madera que esta rota"
	elif dialogo_tienda >= 80 && dialogo_tienda < 90:
		$Label.text = "Podes ir aceptando que
		tus esclavistas no te van a soltar y
		darme todo tu oro"
	elif dialogo_tienda >= 90:
		$Label.text = "Hace frio
		y estas lejos de casaa
		universos aparte sentado
		en esta tienda"
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
	$Tienda1.texture = load("res://Sprites/tienda2.jpeg")
	$Palanca.disabled = true
	$Label.visible_characters = 0
	$Label.text = "Nice"
	for i in $Label.text.length():
		var character = $Label.text[i]
		
		$Label.visible_characters += 1
		await get_tree().create_timer(0.1).timeout
		
		if character.is_valid_identifier():
			AudioManager.play_hombreTienda()
