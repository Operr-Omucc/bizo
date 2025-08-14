extends CharacterBody2D

var speed
var cooldown:bool = true
var money: int
var health: int
var maxHealth: int
@onready var healthBar: TextureProgressBar = $Camera2D/CanvasLayer/TextureProgressBar


func _ready():
	money = 0
	maxHealth = gamedata.maxHealth
	health = gamedata.health
	speed = 500
	maxHealth += gamedata.maxHealth
	health += gamedata.health
	self.add_to_group("personaje")
	
#Movimiento basico
func _physics_process(_delta):
	
	var direccion = Input.get_vector("Izquierda","Derecha","Arriba","Abajo")
	velocity = direccion * speed
	if Input.is_action_just_pressed("Dash") && cooldown:
		start_dash()
	healthBar.value = health
	healthBar.max_value = maxHealth
	gamedata.money_amount += money
	move_and_slide()
	
	
#Funcion de dasheo
func start_dash():
		cooldown = false
		speed = speed + 1500
		await get_tree().create_timer(0.3).timeout
		speed = speed - 1500
		await get_tree().create_timer(1.00).timeout
		cooldown = true
