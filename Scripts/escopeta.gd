extends "arma.gd"

func _ready() -> void:
	fire_rate = gamedata.fire_rate - 0.1
	
	bullet_damage = 10
	if gamedata.damage < 1:
		gamedata.damage += bullet_damage

func fire():
	AudioManager.play_disparo()
	if not cooldown:
		return
	
	var muzzle: Node2D = $Node2D
	var mouse_pos = get_global_mouse_position()
	var base_dir = (mouse_pos - muzzle.global_position).normalized()
	var base_angle = base_dir.angle()
	var spread_deg := 10.0   # máximo en grados
	
	for i in range(8):
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
