extends CharacterBody2D

var speed
var cooldown:bool = true
var money:int

func _ready():
	speed = 500
	self.add_to_group("personaje")

#Movimiento basico
func _physics_process(_delta):
	
	var direccion = Input.get_vector("Izquierda","Derecha","Arriba","Abajo")
	velocity = direccion * speed
	if Input.is_action_just_pressed("Dash") && cooldown:
		start_dash()
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
