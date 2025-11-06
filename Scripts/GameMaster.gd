extends Node2D

# Constante con la lista de enemigos que pueden spawnear
const ENEMIGOS = {
	1: preload("res://Escenas/enemigo.tscn"),
	2: preload("res://Escenas/tanque.tscn"),
	3: preload("res://Escenas/petizo.tscn"),
	4: preload("res://Escenas/tirador.tscn")
}

# Variable del personaje para que se pueda usar en otras funciones
var personaje

# Variable de la dificultad de oleada, osea, la oleada actual + 2, luego se usa para calcular la cantidad
# de enemigos, que es la dificultad de oleada multiplicado la dificultad seleccionada por el jugador
var wave_dif = gamedata.currentWave+2
@export var ene_cant = wave_dif * gamedata.dif

func _physics_process(_delta: float) -> void:
	if gamedata.rep == ene_cant: #revisa si todos los enemigos estan muertos
		gamedata.rep=0
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://Escenas/tienda.tscn") # si todos murieron despues de 5 segundos envia a tienda
	gamedata.debug()
func _ready():
	# Spawnea personaje y enemigos adentro del mundo y hace sonar la musica, ademas establece en y la variable de zona en true
	# "en" es usado en otro script para saber cuantos enemigos hay por oleada 
	# (ene_cant es local, "en" es global y se puede usar en todos los scripts)
	ContinuarPartida.save_game()
	spawn_char()
	AudioManager.stop_tienda()
	AudioManager.play_juego()
	spawn_wave()
	gamedata.zona = true
	gamedata.en = ene_cant
	#FIN DE READY
				
func _on_timer_timeout() -> void:
	if gamedata.currentWave<20:
		get_tree().paused = false #despausa el juego si estaba pausado y luego envia a la tienda
		get_tree().change_scene_to_file("res://Escenas/tienda.tscn")
	elif gamedata.currentWave==20: # si es la oleada 20 no hace nada
		return

func safe_instance(scene: PackedScene) -> Node: #funcion que permite aparecer escenas que son nulas
	if scene != null:
		return scene.instantiate()
	return null

func spawn_wave():
	if gamedata.currentWave < 20: # si la oleada actual es menos de 20 
		for a in ene_cant: # se hace un for que dura la cantidad de enemigos que haya en esa oleada
			if gamedata.pause == true: # si el juego NO esta pausado
				if a <= ene_cant: # y si a es menor a la cantidad de enemigos (es mas como una precaucion) 
					# empieza a spawnear enemigos en zonas aleatorias
					var r = randi_range(1, ENEMIGOS.size())
					var enemigo = ENEMIGOS[r].instantiate()
					add_child(enemigo)
					var intentos = 0 # la variable intentos sirve para saber si se intento hacer aparecer a un enemigo con
									 # exito, osea si un enemigo aparecio a la distancia justa del jugador, si aparecio cerca
									 # entonces no funciona
					var spawn_pos : Vector2

					while intentos < 99:
						spawn_pos = Vector2(
							randi_range(-456, 3712), # pos X
							randi_range(-1296, 3456) # pos Y
						)
						var dist = spawn_pos.distance_to(personaje.global_position)
						if dist >= 500:
							break
						intentos += 1

					enemigo.global_position = spawn_pos # hace que aparezcan y decide que su target es el jugador
					enemigo.target = personaje
					#if gamedata.currentWave > 15:
						#enemigo.health += enemigo.health/2 ### Creo que esta parte estaba durante la expo para bajar la dificultad del juego
					if is_inside_tree():
						await get_tree().create_timer(1).timeout

func spawn_char():
	personaje = gamedata.chara_Scene.instantiate() # instancia al personaje, su arma y su brazo, luego los añade como hijos de la escena y pone su posicion
	var arma = safe_instance(gamedata.gun_scene)
	var brazo = safe_instance(gamedata.arm_scene)
	
	add_child(personaje)
	
	personaje.global_position = Vector2(896, 704)
	
	if arma!=null:
		personaje.add_child(arma)
	if brazo!=null:
		personaje.add_child(brazo)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("personaje"):
		get_tree().change_scene_to_file("res://bizo3ed/node_3d.tscn")
