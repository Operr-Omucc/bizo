extends Node2D

const ENEMIGOS = {
	1: preload("res://Escenas/enemigo.tscn"),
	2: preload("res://Escenas/tanque.tscn"),
	3: preload("res://Escenas/petizo.tscn"),
	4: preload("res://Escenas/tirador.tscn")
}
var personaje

var wave_dif = gamedata.currentWave+2
@export var ene_cant = wave_dif * gamedata.dif

func _physics_process(_delta: float) -> void:
	if gamedata.rep == ene_cant: #revisa si todos los enemigos estan muertos
		gamedata.rep=0
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://Escenas/tienda.tscn")
	gamedata.debug()
func _ready():
	#Spawnea personaje y enemigos adentro del mundo
	spawn_char()
	spawn_wave()
	gamedata.en = ene_cant
	#FIN DE READY
				
func _on_timer_timeout() -> void:
	if gamedata.currentWave<20:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://Escenas/tienda.tscn")
	elif gamedata.currentWave==20:
		return

func safe_instance(scene: PackedScene) -> Node: #funcion que permite aparecer escenas que son nulas
	if scene != null:
		return scene.instantiate()
	return null

func spawn_wave():
	if gamedata.currentWave < 20:
		for a in ene_cant:
			if a <= ene_cant:
				var r = randi_range(1, ENEMIGOS.size())
				var enemigo = ENEMIGOS[r].instantiate()
				add_child(enemigo)
				var intentos = 0
				var spawn_pos : Vector2

				while intentos < 99:
					spawn_pos = Vector2(
						randi_range(-600, 3712), # pos X
						randi_range(-1832, 3648) # pos Y
					)
					var dist = spawn_pos.distance_to(personaje.global_position)
					if dist >= 500:
						break
					intentos += 1

				enemigo.global_position = spawn_pos
				enemigo.target = personaje
				if gamedata.currentWave > 15:
					enemigo.health += enemigo.health/2
				if is_inside_tree():
					await get_tree().create_timer(1).timeout

func spawn_char():
	personaje = gamedata.chara_Scene.instantiate()
	var arma = safe_instance(gamedata.gun_scene)
	var brazo = safe_instance(gamedata.arm_scene)
	
	add_child(personaje)
	
	personaje.global_position = Vector2(896, 704)
	
	if arma!=null:
		personaje.add_child(arma)
		arma.position = Vector2(120.0, 30.0)
	if brazo!=null:
		personaje.add_child(brazo)
