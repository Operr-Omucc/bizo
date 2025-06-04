extends CharacterBody2D

var speed = 500
var cooldown:bool = true


#Movimiento basico
func _physics_process(_delta):
	var direccion = Input.get_vector("Izquierda","Derecha","Arriba","Abajo")
	velocity = direccion * speed
	if Input.is_action_just_pressed("Dash") && cooldown:
		start_dash()
	move_and_slide()
	
	
#Funcion de dasheo
func start_dash():
		cooldown = false
		speed = 1500
		await get_tree().create_timer(0.3).timeout
		speed = 500
		await get_tree().create_timer(1.00).timeout
		cooldown = true
