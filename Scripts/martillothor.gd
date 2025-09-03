extends Node2D

var puede_golpear: bool
var cooldown = true
var CeroCooldown: bool = true

var fire_rate: float = gamedata.fire_rate + 0.5
var posicion_original: Vector2

@onready var animacion_martillo: AnimationPlayer = $"Hombro/Sprite2D/Puño/AnimationPlayer"
@onready var muzzle: Marker2D = $"Hombro/Sprite2D/Puño/Marker2D"
@onready var brazo = $"Hombro/Sprite2D/Puño"

func _ready() -> void:
	fire_rate =  gamedata.fire_rate + 0.5

#funcion para que el arma mire a la posicion del mouse + revisa si el jugador disparo
func _physics_process(_delta):
	if Input.is_action_just_pressed("Disparo") && cooldown:
		fire()
	if Input.is_action_just_pressed("Brazo"):
		golpear()
	if Input.is_action_just_pressed("Dash"):
		CeroMetralleta()

func golpear():
	animacion_martillo.play("martillo/Golpe", 0.0, 3.0)
	puede_golpear = true
	brazo.damage = 20

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "martillo/Golpe":
		position = posicion_original
		puede_golpear = false
		brazo.damage = 0
		

#funcion de disparo :P
func fire():
	AudioManager.play_disparo()
	if not cooldown:
		return
	var ray = preload("res://Escenas/rayo.tscn").instantiate()
	
	#establece la posicion, rotacion y direccion de la bala
	ray.pos = muzzle.global_position
	ray.rota = muzzle.global_rotation
	ray.dir = Vector2.RIGHT.rotated(muzzle.global_rotation) # opcional
	
	#añade la bala al arbol actual
	get_tree().current_scene.add_child(ray)
	
	cooldown = false
	await get_tree().create_timer(fire_rate).timeout
	cooldown = true
	
func CeroMetralleta():
	var rando = randi_range(10, 100)
	
	if CeroCooldown == true:
		CeroCooldown = false
		for i in rando:
			
			var ray = preload("res://Escenas/rayo.tscn").instantiate()
			
			# Copiamos la posición del muzzle y le agregamos un Y aleatorio
			var pos = muzzle.global_position
			
			# Dirección hacia el mouse
			ray.pos = muzzle.global_position
			ray.pos.y += randi_range(-600, 600)
			ray.rota = muzzle.global_rotation
			ray.dir = Vector2.RIGHT.rotated(muzzle.global_rotation) # opcional
			
			# Añade la bala al árbol
			get_tree().current_scene.add_child(ray)

			# Añade Cooldown
			cooldown = false
			await get_tree().create_timer(0.1).timeout
			cooldown = true
		await get_tree().create_timer(10).timeout
		CeroCooldown = true
