extends CharacterBody2D
#cargar escena de bala
@onready var bullet_path= preload("res://Escenas/bala.tscn")
var cooldown = true
var fire_rate: float
@export var bullet_damage: int
@onready var animacion_martillo: AnimationPlayer = $AnimationPlayer
var puede_golpear: bool
var damage: int
var posicion_original: Vector2

func _ready() -> void:
	fire_rate =  gamedata.fire_rate - 0.3
	bullet_damage = 20
	if gamedata.damage <1:
		gamedata.damage += bullet_damage

#funcion para que el arma mire a la posicion del mouse + revisa si el jugador disparo
func _physics_process(_delta):
	if Input.is_action_just_pressed("Brazo"):
		golpear()

func golpear():
	animacion_martillo.play("martillo/Golpe", 0.0, 3.0)
	puede_golpear = true
	damage = 20

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Golpe":
		position = posicion_original
		puede_golpear = false
		damage = 0
		
#funcion de disparo :P
#func fire():
	#var bullet=bullet_path.instantiate()
	#bullet.add_to_group("bala")
	#bullet.dir=rotation
	#bullet.pos=$Node2D.global_position
	#bullet.rota=global_rotation
	#get_parent().get_parent().add_child(bullet)
	#cooldown = false
	#await get_tree().create_timer(fire_rate).timeout
	#cooldown = true
