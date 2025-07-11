extends CharacterBody2D

var speed
var cooldown:bool = true
var money:int
var health: int
var maxHealth: int
@onready var healthBar: TextureProgressBar = $Camera2D/TextureProgressBar


func _ready():
	maxHealth = 100
	health = 100
	speed = 500
	self.add_to_group("personaje")
	
#Movimiento basico
func _physics_process(_delta):
	
	var direccion = Input.get_vector("Izquierda","Derecha","Arriba","Abajo")
	velocity = direccion * speed
	if Input.is_action_just_pressed("Dash") && cooldown:
		start_dash()
	healthBar.value = health
	healthBar.max_value = maxHealth
	#is_mouse_left()
	move_and_slide()
	
	
#Funcion de dasheo
func start_dash():
		cooldown = false
		speed = speed + 1500
		await get_tree().create_timer(0.3).timeout
		speed = speed - 1500
		await get_tree().create_timer(1.00).timeout
		cooldown = true
