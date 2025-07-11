extends CharacterBody2D
#cargar escena de bala
var bullet_path=preload("res://Escenas/bala.tscn")
var cooldown = true

#funcion para que el arma mire a la posicion del mouse + revisa si el jugador disparo
func _physics_process(_delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Disparo") && cooldown:
		fire()
		
#funcion de disparo :P
func fire():
	var bullet=bullet_path.instantiate()
	bullet.add_to_group("bala")
	bullet.dir=rotation
	bullet.pos=$Node2D.global_position
	bullet.rota=global_rotation
	get_parent().get_parent().add_child(bullet)
	cooldown = false
	await get_tree().create_timer(1.00).timeout
	cooldown = true
