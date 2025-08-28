extends CharacterBody2D

var speed
var cooldown:bool = true
var health: int
var maxHealth: int
@onready var healthBar: TextureProgressBar = $Camera2D/CanvasLayer/TextureProgressBar
@onready var jefe: CharacterBody2D = $"."


func _ready():
	maxHealth = gamedata.maxHealth
	health = gamedata.health
	speed = gamedata.speed+500
	self.add_to_group("personaje")
	
#Movimiento basico
func _physics_process(_delta):
	on_death()
	var direccion = Input.get_vector("Izquierda","Derecha","Arriba","Abajo")
	velocity = direccion * speed
	if Input.is_action_just_pressed("Dash") && cooldown:
		start_dash()
	healthBar.value = health
	healthBar.max_value = maxHealth
	move_and_slide()
	
	if health < 1:
		gamedata.currentWave = 1
		get_tree().call_deferred("change_scene_to_file","res://Escenas/derrota.tscn")
	
	
#Funcion de dasheo
func start_dash():
		cooldown = false
		speed = speed + 1500
		await get_tree().create_timer(0.3).timeout
		speed = speed - 1500
		await get_tree().create_timer(1.00).timeout
		cooldown = true

func on_death():
		if health < 1:
			gamedata.currentWave = 1
			get_tree().call_deferred("change_scene_to_file","res://Escenas/main_menu.tscn")
		elif health > 1:
			return
