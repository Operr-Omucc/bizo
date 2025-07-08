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
	
	#is_mouse_left()
	move_and_slide()
	
	
#Funcion de dasheo
func start_dash():
		cooldown = false
		speed = 1500
		await get_tree().create_timer(0.3).timeout
		speed = 500
		await get_tree().create_timer(1.00).timeout
		cooldown = true

#Funcion que detecta si el personaje mira para la izquierda o no
func is_mouse_left():

	#var alsod = 0 < get_position_delta().x 
	var onLeftSide = 0<get_global_mouse_position().x
	
	if onLeftSide:
		self.scale.x = -1
	else:
		self.scale.x = 1
	
