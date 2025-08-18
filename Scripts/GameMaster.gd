extends Node2D

var personaje = gamedata.chara_Scene.instantiate()
var arma =safe_instance(gamedata.gun_scene)
var brazo = safe_instance(gamedata.arm_scene)
var wave_dif = gamedata.currentWave+2
var dif = gamedata.dif

func _physics_process(_delta: float) -> void:
	if gamedata.rep == wave_dif*dif: #revisa si todos los enemigos estan muertos
		gamedata.rep=0
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://Escenas/tienda.tscn")
		
func _ready():
	#Spawnea todo adentro del mundo
	
	add_child(personaje)
	personaje.global_position = Vector2(896, 704)

	# Añade arma al personaje
	if arma!=null:
		personaje.add_child(arma)
		arma.position = Vector2(120.0, 30.0)
	if brazo!=null:
		personaje.add_child(brazo)
		arma.position = Vector2(120.0, 30.0)

	# Añade enemigo
	if gamedata.currentWave<20:
		for n in (wave_dif * dif):
			var enemigo = preload("res://Escenas/enemigo.tscn").instantiate()
			add_child(enemigo)
			enemigo.global_position = Vector2(randi_range(608, 2560), randi_range(16, 2704))
			enemigo.target = personaje
			await get_tree().create_timer(1).timeout
			
func _on_timer_timeout() -> void:
	if gamedata.currentWave<20:
		get_tree().change_scene_to_file("res://Escenas/tienda.tscn")
	elif gamedata.currentWave==20:
		return

func safe_instance(scene: PackedScene) -> Node: #funcion que permite aparecer escenas que son nulas
	if scene != null:
		return scene.instantiate()
	return null
