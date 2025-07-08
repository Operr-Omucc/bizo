extends CharacterBody2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var target = get_tree().get_nodes_in_group("personaje")
@onready var coin=preload("res://Escenas/moneda.tscn")

var speed=150

func _ready() -> void:
	await get_tree().process_frame
	var jugadores = get_tree().get_nodes_in_group("jugador")
	set_physics_process(false)
	call_deferred("wait_for_physics")
	
func wait_for_physics():
	await get_tree().physics_frame
	set_physics_process(true)

#Funcion para eliminar personaje + deteccion de colision con bala
func _on_area_2d_body_entered(body):
	if body.is_in_group("personaje"):
		get_tree().call_deferred("change_scene_to_file","res://Escenas/main_menu.tscn")
	elif body.is_in_group("bala"):
		var coin_instance = coin.instantiate()
		coin_instance.add_to_group("coins")
		coin_instance.position = global_position

		get_parent().call_deferred("add_child", coin_instance)  # safe add
		call_deferred("queue_free")  # safely delete self
		body.call_deferred("queue_free")  # safely delete bullet
		
#funcion que se ejecuta cada segundo, funciona tambien para detectar la posicion del jugador y perseguirlo
func _physics_process(_delta):
	if target and target.is_inside_tree():
		if navigation_agent.is_navigation_finished():
			var distancia = target.global_position.distance_to(navigation_agent.target_position)
			if distancia < 4:
				return  # Ya llegó o no necesita recalcular
		navigation_agent.target_position = target.global_position

		var siguiente = navigation_agent.get_next_path_position()
		if siguiente != Vector2.ZERO:
			velocity = global_position.direction_to(siguiente) * speed
		else:
			velocity = Vector2.ZERO  # Sin dirección válida
		move_and_slide()
