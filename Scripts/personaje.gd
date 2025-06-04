extends CharacterBody2D

func _physics_process(_delta):
	var direccion = Input.get_vector("Izquierda","Derecha","Arriba","Abajo")
	velocity = direccion * 500
	move_and_slide()
