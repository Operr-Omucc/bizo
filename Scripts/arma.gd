extends CharacterBody2D
#cargar escena de bala
@onready var bullet_path= preload("res://Escenas/bala.tscn")
var cooldown = true
var fire_rate: float
@export var bullet_damage: int

func _ready() -> void:
	fire_rate =  gamedata.fire_rate - 0.3
	bullet_damage = 20
	if gamedata.damage <1:
		gamedata.damage += bullet_damage

#funcion para que el arma mire a la posicion del mouse + revisa si el jugador disparo
func _physics_process(_delta):
	bullet_damage = gamedata.damage
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Disparo") && cooldown:
		fire()
		
### FUNCIONES 
		
#funcion de disparo :P
func fire():
	AudioManager.play_disparo()
	if not cooldown:
		return
	#instancia la bala y añade el marker2D para poder disparar
	var bullet = bullet_path.instantiate()
	var muzzle: Node2D = $Node2D
	#establece la posicion, rotacion y direccion de la bala
	bullet.pos = muzzle.global_position
	bullet.rota = muzzle.global_rotation
	bullet.dir = Vector2.RIGHT.rotated(muzzle.global_rotation) # opcional
	#añade la bala al arbol actual
	get_tree().current_scene.add_child(bullet)
	#propiedades de cooldown
	cooldown = false
	await get_tree().create_timer(fire_rate).timeout
	cooldown = true
