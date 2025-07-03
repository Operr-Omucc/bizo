extends CharacterBody2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var target=%Personaje
@onready var coin=preload("res://Escenas/moneda.tscn")

var speed=150

func _ready() -> void:
	set_physics_process(false)
	call_deferred("wait_for_physics")
	
func wait_for_physics():
	await get_tree().physics_frame
	set_physics_process(true)

#Funcion para eliminar personaje + deteccion de colision con bala
func _on_area_2d_body_entered(body):
	if body.name=="Personaje":
		body.queue_free()
	elif body.is_in_group("bala"):
		var coin_instance = coin.instantiate()
		coin_instance.add_to_group("coins")
		coin_instance.position = global_position

		get_parent().call_deferred("add_child", coin_instance)  # safe add
		call_deferred("queue_free")  # safely delete self
		body.call_deferred("queue_free")  # safely delete bullet
		
#funcion que se ejecuta cada segundo, funciona tambien para detectar la posicion del jugador y perseguirlo
func _physics_process(_delta):
	if target!=null:
		if navigation_agent.is_navigation_finished() and target.global_position==navigation_agent.target_position:
			return
		navigation_agent.target_position = target.global_position
		velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * speed
	move_and_slide()
