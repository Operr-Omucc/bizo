extends CharacterBody2D
#cargar escena de bala
@onready var bullet_path= preload("res://Escenas/bala.tscn")
var cooldown = true
var fire_rate: float
@export var bullet_damage: int

func _ready() -> void:
	fire_rate = 0.70
	bullet_damage = 20
	gamedata.damage = bullet_damage

#funcion para que el arma mire a la posicion del mouse + revisa si el jugador disparo
func _physics_process(_delta):
	bullet_damage = gamedata.damage
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Disparo") && cooldown:
		fire()
		
#funcion de disparo :P
func fire():
	var bullet=bullet_path.instantiate()
	bullet.damage=bullet_damage
	bullet.add_to_group("bala")
	bullet.dir=rotation
	bullet.pos=$Node2D.global_position
	bullet.rota=global_rotation
	get_parent().get_parent().add_child(bullet)
	cooldown = false
	await get_tree().create_timer(fire_rate).timeout
	cooldown = true
