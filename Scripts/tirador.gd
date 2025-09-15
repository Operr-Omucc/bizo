extends CharacterBody2D
@onready var torreta = $torreta
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var target = get_tree().get_nodes_in_group("personaje")
@onready var coin=preload("res://Escenas/moneda.tscn")
var health: int
var cooldown=true
var speed=150
var damage = gamedata.enemy_damage()

var is_dead: bool = false
var knockback: Vector2=Vector2.ZERO
var knockback_timer: float=0.0

func _ready() -> void:
	self.add_to_group("enemigo")
	health = 20
	await get_tree().process_frame
	set_physics_process(false)
	if self.is_inside_tree():
		await get_tree().create_timer(1.00).timeout
	call_deferred("wait_for_physics")
	
func wait_for_physics():
	if not is_inside_tree():
		return
	await get_tree().physics_frame
	if not is_inside_tree():
		return
	set_physics_process(true)


#Funcion para eliminar personaje + deteccion de colision con bala de ser verdadero quita vida al enemigo/jugador
func _on_area_2d_body_entered(body):
	if is_dead:
		return
	
	if body.is_in_group("personaje"):
		
		if body.health > 0 && cooldown:
			body.health -= damage
			var direction = (body.global_position - global_position).normalized()
			body.velocity += direction * 1000
			cooldown = false
			await get_tree().create_timer(1.00).timeout #tiempo de invulnerabilidad del jugador
			cooldown = true
			
			
	elif body.is_in_group("bala") || body.is_in_group("brazo"):
		if health > 0:
			health = health - body.damage
			body.call_deferred("queue_free") #call deferred añade/quita  de forma "segura"
			
		if health <= 1:
			death_check()
		
func _physics_process(_delta):
	if knockback_timer > 0.0:
			velocity = knockback * 5
			knockback_timer -= _delta
			if knockback_timer <= 0.0:
				knockback = Vector2.ZERO
	navegacion(_delta)
	move_and_slide()
	
#funcion que se ejecuta cada segundo, funciona tambien para detectar la posicion del jugador y perseguirlo
func navegacion(_delta):
	if target and target.is_inside_tree():
		navigation_agent.target_position = target.global_position

		var distancia = global_position.distance_to(target.global_position)

		if distancia < 800:  # Puedes ajustar esta distancia
			speed = 0
			torreta.disparo()
		else:
			speed = 150  # Velocidad normal

		var siguiente = navigation_agent.get_next_path_position()
		if siguiente != Vector2.ZERO:
			velocity = global_position.direction_to(siguiente) * speed
		else:
			velocity = Vector2.ZERO

		
func apply_knockback(knockback_direction: Vector2, knockback_force: float, knockback_duration: float) -> void:
	knockback = knockback_direction * knockback_force
	knockback_timer = knockback_duration


func _on_area_2d_area_entered(area: Area2D) -> void:
	if is_dead:
		return
	if area.is_in_group("brazo") || area.is_in_group("bala"):
		if health > 0:
			health = health - area.damage
			
		if health <= 1:
			death_check()

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
