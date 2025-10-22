extends CharacterBody2D

# Variables para que el enemigo pueda navegar el mapa y trackear al personaje, ademas de la moneda que sueltan al morir
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var target = get_tree().get_nodes_in_group("personaje")
@onready var coin=preload("res://Escenas/moneda.tscn")

# Variables que tienen que ver con los stats de los enemigos, osea vida, velocidad, daño y el cooldown de sus ataques
var health: int
var cooldown=true
var speed=150
var damage = gamedata.enemy_damage()

# Variables como cuanto knockback sufren y si esta muerto
var is_dead: bool = false
var knockback: Vector2=Vector2.ZERO
var knockback_timer: float=0.0

# Establece todo lo necesario para que sea considerado enemigo, osea su vida, su grupo y hace que espere un segundo antes de que corra el codigo
func _ready() -> void:
	self.add_to_group("enemigo")
	health = 40
	await get_tree().process_frame
	set_physics_process(false)
	await get_tree().create_timer(1.00).timeout
	call_deferred("wait_for_physics")
	
	# Es la funcion usada en la linea superior a esta que hace que espere hasta que este dentro del arbol
	# Existe para solucionar bugs
func wait_for_physics():
	if not is_inside_tree():
		return
	await get_tree().physics_frame
	if not is_inside_tree():
		return
	set_physics_process(true)

# Es una variable usada para detectar si muere, si muere instancia una moneda y añade +1 al rep
# (rep explicado en el script gamedata)
func death_check():
	call_deferred("queue_free")
	if is_dead:
		return
	is_dead = true
	gamedata.rep += 1
	var coin_instance = coin.instantiate()
	coin_instance.add_to_group("coins")
	coin_instance.position = global_position
	get_parent().call_deferred("add_child", coin_instance)  
	

#Funcion para eliminar personaje + deteccion de colision con bala de ser verdadero quita vida al enemigo/jugador
func _on_area_2d_body_entered(body):
	# Si golpea al personaje
	if body.is_in_group("personaje"):
		
		if body.health > 0 && cooldown:
			AudioManager.play_golpe()
			body.health -= damage
			var direction = (body.global_position - global_position).normalized()
			body.velocity += direction / 1000
			cooldown = false
			await get_tree().create_timer(1.00).timeout #tiempo de invulnerabilidad del jugador
			cooldown = true
			
			# (comentario mas nuevo) Para revisar si el enemigo fue golpeado
			# Esta parte existe para revisar si el enemigo esta muerto, en cuyo caso lo elimina de la escena
	elif body.is_in_group("bala") || body.is_in_group("brazo"):
		if health > 0:
			health = health - body.damage
			body.call_deferred("queue_free") #call deferred añade/quita  de forma "segura"
			
		if health <= 0:
			death_check()
		
		# Cada segundo procesa el timer del knockback si es golpeado, si no, navega el mapa como deberia
func _physics_process(_delta):
	if knockback_timer > 0.0:
			velocity = knockback * 5
			knockback_timer -= _delta
			if knockback_timer <= 0.0:
				knockback = Vector2.ZERO
	else:
		_navegacion(_delta)
	
#funcion que se ejecuta cada segundo, funciona tambien para detectar la posicion del jugador y perseguirlo
func _navegacion(_delta):
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
		
# Funcion para aplicar el knockback, multiplica direccion del knockback por fuerza y luego establece el timer
func apply_knockback(knockback_direction: Vector2, knockback_force: float, knockback_duration: float) -> void:
	knockback = knockback_direction * knockback_force
	knockback_timer = knockback_duration

# Hay dos funciones que detectan areas entrando, pero es un tema complicado porque tenemos las balas
# que son un Body y tenemos al martillo de thor, cuestion, todos los ataques del martillo de thor
# son de tipo "Area2D" como no podemos detectar Area2D y Body al mismo tiempo entonces hicimos
# Dos funciones distintas que hacen esencialmente lo mismo pero para distintos tipos de arma 
func _on_area_2d_area_entered(area: Area2D) -> void:
	if is_dead:
		return
	if area.is_in_group("brazo") || area.is_in_group("bala"):
		if health > 0:
			health = health - area.damage
			
		if health <= 0:
			death_check()
