extends Node2D

# Variable encargada de establecer el 
@onready var mejora_path= preload("res://Escenas/mejora.tscn")

# Variables encargadas de, cuanto es el precio base de las tiradas, una variable que se usa despues
# para las mejoras, una variable que se aleatoriza para decidir el dialogo del de la tienda y
# una variable para decidir el precio final para que el tipo pueda decir el precio 
var reroll:int = 3
var mejora
var dialogo_tienda : int
var precio : int

# Funcion para debugear el juego
func _physics_process(_delta: float) -> void:
	gamedata.debug()

# Funcion que calcula el precio de la tienda basandose en el reroll multiplicado la oleada actual
# tambien detiene la musica del juego principal y empieza la de la tienda, hace zona false para
# el archivo de guardado, guarda el juego y actualiza el texto de la tirada despues de poner su
# color en negro
func _ready() -> void:
	precio = reroll * gamedata.currentWave
	AudioManager.stop_juego()
	AudioManager.play_tienda()
	gamedata.zona = false
	ContinuarPartida.save_game()
	actualizarTextoTirada()
	
	# Funcion que te devuelve al juego principal, añade una oleada mas, pone el rep en 0 para
	# que pueda volver a contar, si quedan mejoras las elimina y pregunta si es la oleada 20
	# o no, si no es entonces te lleva al juego y si es entonces a la batalla del jefe
func _on_button_3_pressed() -> void:
	gamedata.currentWave += 1 
	gamedata.rep = 0
	if mejora!=null:
		mejora.queue_free()
	if gamedata.currentWave == 20:
		get_tree().change_scene_to_file("res://Escenas/batalla_jefe.tscn")
	elif gamedata.currentWave < 20:
		get_tree().change_scene_to_file("res://Escenas/mundo.tscn")

# Funcion que cuando la palanca es presionada decide cual va a ser el dialogo de la tienda,
# se pregunta si tenes plata, si tenes usa la funcion actualizarTextoRico(), que lo que hace es
# actualizar el texto para que diga nice y te complete la compra, luego vuelve al texto normal,
# si no tenes plata usa actualizarTextoPobre() no te quita nada de plata pero basicamente hace
# que el tipo de la tienda no te deje comprar, los dialogos pueden ser revisados en sus respectivas funciones
func _on_palanca_pressed() -> void:
	dialogo_tienda = randi() % 100
	if gamedata.money_amount >= precio:
		actualizarTextoRico()
		
		# Acá quitamos el dinero y procesamos la compra
		gamedata.money_amount -= precio
		for n in (3):
			# Se instancia la mejora y se le da un tipo, con un rango de 1 a 92, dependiendo del numero que
			# salga se usa una mejora u otra, luego se añade como hijo de la escena y se establece una posicion
			# se crea un timer de 1 segundo para que haya 1 segundo entre mejora y mejora
			mejora = mejora_path.instantiate()
			mejora.tipo_mejora = randi_range(1,92)
			get_parent().add_child(mejora)
			mejora.global_position= Vector2(262, 72)
			await get_tree().create_timer(1).timeout
			
		actualizarTextoTirada()
	elif gamedata.money_amount<precio:
		actualizarTextoPobre()
		await get_tree().create_timer(5).timeout
		actualizarTextoTirada()
	
	
# Actualiza el texto de las tiradas, mucho codigo porque hay muchos textos, la ultima probabilidad es
# un chiste de nuestro grupo y puede ser eliminada a pedido de cualquier profesor de inmediato si se pide
func actualizarTextoTirada():
	$Palanca.disabled = true
	$Tienda1.texture = load("res://Sprites/tienda2.png")
	$Label.visible_characters = 0
	if dialogo_tienda < 50:
		$Label.text = "Tenes %s dinero,
		gastalo bien, la tirada cuesta %s" % [gamedata.money_amount, precio]
	elif dialogo_tienda >= 50 && dialogo_tienda < 80:
		$Label.text = "no quiero arreglar 
		la madera que esta rota"
	elif dialogo_tienda >= 80 && dialogo_tienda < 90:
		$Label.text = "Podes ir 
		dandome todo tu oro"
	elif dialogo_tienda >= 90 && dialogo_tienda <= 100:
		$Label.text = "Hace frio
		y estas lejos de casaa
		universos aparte sentado
		en esta tienda"
	#elif dialogo_tienda == 100:
	#	$Label.text = "estamos en todos los
	#	universos, el imperio no, los judios"
	
	
	# Esta parte la explico aparte porque es medio complicada
	actualizarLetra()
	
	# luego de todo eso la palanca se vuelve a poder presionar
	await get_tree().create_timer(5).timeout
	$Palanca.disabled = false
	
	
func actualizarTextoPobre():
	# Al momento que empieza la funcion la palanca se desactiva para evitar bugs
	$Palanca.disabled = true
	
	# se establecen todos los caracteres visibles en 0 y luego se establece el texto de la label
	$Label.visible_characters = 0
	$Label.text = "No tenes dinero pa jaja salu2"
	
	actualizarLetra()
			
			
func actualizarTextoRico():
	# Primero como en las otras ocasiones la palanca se desactiva, ademas cambiamos el sprite del
	# hombre de la tienda para poner la otra cara, establecemos todos los caracteres como invisibles
	# y ponemos de texto nice
	$Tienda1.texture = load("res://Sprites/tienda1.png")
	$Palanca.disabled = true
	$Label.visible_characters = 0
	$Label.text = "Nice"
	
	actualizarLetra()

func actualizarLetra():
	for i in range($Label.text.length()):
		# esta variable decide cuantas letras tiene la label
		var character = $Label.text[i]
		
		# luego hace cada caracter visible 1 por 1
		$Label.visible_characters += 1
		await get_tree().create_timer(0.046).timeout
		
		# luego de un milisegundo de volver al caracter actual visible se pregunta si es valido
		# osea si no es un numero, espacio o caracter especial como las letras con tilde, si es valido
		# hace el sonido del hombre de tienda
		if character.is_valid_identifier():
			AudioManager.play_hombreTienda()
