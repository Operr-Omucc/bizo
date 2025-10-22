extends "arma.gd"

var modo_varita : bool
var cooldown2 = true

func _ready() -> void:
	fire_rate = gamedata.fire_rate + 0.7
	
	bullet_damage = 1
	if gamedata.damage < 1:
		gamedata.damage += bullet_damage

func _physics_process(_delta):
	if Input.is_action_just_pressed("Dash"):
		if modo_varita == true:
			modo_varita = false
		else:
			modo_varita = true
	rota()
	gamedata.damage = bullet_damage 
	if Input.is_action_just_pressed("Disparo") && cooldown && modo_varita==true:
		fire()
	elif Input.is_action_just_pressed("Disparo") && cooldown2 && modo_varita==false:
		fire2()

func fire():
	AudioManager.play_disparo()
	if not cooldown:
		return
	
	var muzzle: Node2D = $Node2D
	var mouse_pos = get_global_mouse_position()
	var base_dir = (mouse_pos - muzzle.global_position).normalized()
	var base_angle = base_dir.angle()
	var spread_deg := 360   # máximo en grados
	
	for i in range(60):
		var bullet = bullet_path.instantiate()
		
		# pequeño spread en radianes
		var spread = deg_to_rad(randf_range(-spread_deg, spread_deg))
		var final_angle = base_angle + spread
		var dir = Vector2.RIGHT.rotated(final_angle)
		
		# posición de salida
		bullet.pos = muzzle.global_position
		bullet.rota = final_angle
		bullet.dir = dir
		
		get_tree().current_scene.add_child(bullet)
	
	# propiedades de cooldown
	cooldown = false
	await get_tree().create_timer(fire_rate).timeout
	cooldown = true

func fire2():
	AudioManager.play_disparo()
	if not cooldown:
		return
	
	var muzzle: Node2D = $Node2D
	var mouse_pos = get_global_mouse_position()
	var base_dir = (mouse_pos - muzzle.global_position).normalized()
	var base_angle = base_dir.angle()
	var spread_deg := 20.0   # máximo en grados
	
	for i in range(20):
		var bullet = bullet_path.instantiate()
		
		# pequeño spread en radianes
		var spread = deg_to_rad(randf_range(-spread_deg, spread_deg))
		var final_angle = base_angle + spread
		var dir = Vector2.RIGHT.rotated(final_angle)
		
		# posición de salida
		bullet.pos = muzzle.global_position
		bullet.rota = final_angle
		bullet.dir = dir
		
		get_tree().current_scene.add_child(bullet)
	
	# propiedades de cooldown
	cooldown2 = false
	await get_tree().create_timer(fire_rate).timeout
	cooldown2 = true
