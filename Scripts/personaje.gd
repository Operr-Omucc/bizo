extends CharacterBody2D

@onready var personaje = %Personaje
var speed = 500
var cooldown:bool = true
var money:int

#Movimiento basico
func _physics_process(_delta):
	personaje.add_to_group("personaje")
	var direccion = Input.get_vector("Izquierda","Derecha","Arriba","Abajo")
	velocity = direccion * speed
	if Input.is_action_just_pressed("Dash") && cooldown:
		start_dash()
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
		personaje.scale.x = -1
	else:
		personaje.scale.x = 1
	
