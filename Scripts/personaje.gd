extends CharacterBody2D

# Stats del personaje
var speed
var cooldown:bool = true
var health: int
var maxHealth: int

# Carga de elementos como la barra de vida y el archivo de animacion
@onready var healthBar: TextureProgressBar = $GUI/GUI/TextureProgressBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Funcion que prepara al personaje cuando es instanciado, si detecta que la oleada es la primera se agrega velocidad
# ya que esta variable es reiniciada a 0 cada vez que se termina la partida 
func _ready():
	animation_player.play("Quieto")
	maxHealth = gamedata.maxHealth
	health = gamedata.health
	if gamedata.currentWave == 1:
		gamedata.speed=+500
	self.add_to_group("personaje")
	speed = gamedata.speed
	
#Movimiento basico
func _physics_process(_delta):
	
	on_death()
	var direccion = Input.get_vector("Izquierda","Derecha","Arriba","Abajo")
	velocity = direccion * speed
	#if Input.is_action_just_pressed("Dash") && cooldown:
		#start_dash() AGREGAR A PJ VOLADOR XD
	healthBar.value = health
	healthBar.max_value = maxHealth
	move_and_slide()
	on_death()
	
	
#Funcion de dasheo AGREGAR A PJ VOLADOR XD (que todavia no tenemos, xd)
#func start_dash():
		#cooldown = false
		#speed = speed + 1500
		#await get_tree().create_timer(0.3).timeout
		#speed = speed - 1500
		#await get_tree().create_timer(1.00).timeout
		#cooldown = true

# Funcion de muerte, pone la oleada a la primera y cambia de escena al menu principal
# por varias razones incluyendo al olvido en muchos scripts donde la muerte del jugador esta involucrada 
# se cambia de escena o se reinician las stats, pido porfa que ignoren eso porque soy medio retrasado
# y siempre me olvido de quitar esas funciones y dejar solo una para la muerte 😭😭😭
func on_death():
		if health < 1:
			gamedata.currentWave = 1
			gamedata.rep = 0
			get_tree().call_deferred("change_scene_to_file","res://Escenas/main_menu.tscn")
		elif health > 1:
			return
