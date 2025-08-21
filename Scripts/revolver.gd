extends 'res://Scripts/arma.gd'
var shots_fired = 0


func _ready():
	fire_rate = gamedata.fire_rate - 0.7
	bullet_damage = 40
	if gamedata.damage <1:
		gamedata.damage += bullet_damage
	cooldown = true
	
func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Disparo") and cooldown==true:
		shoot_count()

func shoot_count():
	if shots_fired<6:
		fire()
		shots_fired+=1
	elif shots_fired==6:
		cooldown = false
		await get_tree().create_timer(2).timeout
		cooldown = true
		shots_fired=0
