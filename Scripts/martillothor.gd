extends Node2D

# Variables booleanas que existen para verificar si puede golpear, si esta en cooldown el disparo o si la
# habilidad especial del personaje esta en cooldown
var puede_golpear: bool
var cooldown = true
var CeroCooldown: bool = true

# Variables de la velocidad de disparo y la posicion del martillo
var fire_rate: float = gamedata.fire_rate + 0.5
var posicion_original: Vector2

# Variables relacionadas a cosas del martillo como su animacion, establece la variable del "cañoñ" (donde sale
# el rayo) y el brazo del martillo
@onready var animacion_martillo: AnimationPlayer = $"Hombro/Sprite2D/Puño/AnimationPlayer"
@onready var muzzle: Marker2D = $"Hombro/Sprite2D/Puño/Marker2D"
@onready var brazo = $"Hombro/Sprite2D/Puño"

# Funcion que establece cosas como la velocidad de disparo, si la oleada es la primera establece velocidad
func _ready() -> void:
	fire_rate =  gamedata.fire_rate + 0.5
	if gamedata.currentWave == 1:
		gamedata.damage = 100
	else:
		return

# Funcion que revisa si el jugador disparo, golpeo, o uso la habilidad del personaje (se corre cada segundo)
func _physics_process(_delta):
	if Input.is_action_just_pressed("Disparo") && cooldown:
		fire()
	if Input.is_action_just_pressed("Brazo"):
		golpear()
	if Input.is_action_just_pressed("Dash"):
		CeroMetralleta()

# Funcion que se encarga de habilitar el daño cuando el martillo esta en animacion (se hace
# para que no se pueda golpear con el martillo si no usaste el clic derecho)
func golpear():
	animacion_martillo.play("martillo/Golpe", 0.0, 3.0)
	puede_golpear = true
	brazo.damage = 20

# Funcion que se encarga de la animacion del martillo cuando finaliza
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "martillo/Golpe":
		position = posicion_original
		puede_golpear = false
		brazo.damage = 0
		

# funcion de disparo :P
func fire():
	AudioManager.play_rayo()
	if not cooldown:
		return
	var ray = preload("res://Escenas/rayo.tscn").instantiate()
	
	# establece la posicion, rotacion y direccion de la bala
	ray.pos = muzzle.global_position
	ray.rota = muzzle.global_rotation
	ray.dir = Vector2.RIGHT.rotated(muzzle.global_rotation) # opcional
	
	# añade la bala al arbol actual
	get_tree().current_scene.add_child(ray)
	
	cooldown = false
	await get_tree().create_timer(fire_rate).timeout
	cooldown = true
	
func CeroMetralleta():
	var rando = randi_range(10, 100)
	if self != null:
		if CeroCooldown == true:
			CeroCooldown = false
			for i in rando:
					var ray = preload("res://Escenas/rayo.tscn").instantiate()
					
					# Copiamos la posición del muzzle para agregarle un Y aleatorio mas adelante
					var pos = muzzle.global_position
					
					# Dirección hacia el mouse
					ray.pos = muzzle.global_position
					ray.pos.y += randi_range(-600, 600)
					ray.rota = muzzle.global_rotation
					ray.dir = Vector2.RIGHT.rotated(muzzle.global_rotation) 
					
					# Añade la bala al árbol
					if is_inside_tree():
						get_tree().current_scene.add_child(ray)

					# Añade Cooldown
					if is_inside_tree():
						cooldown = false
						await get_tree().create_timer(0.1).timeout
						cooldown = true
			if is_inside_tree():
				await get_tree().create_timer(10).timeout
			CeroCooldown = true
