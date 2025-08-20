extends CharacterBody2D
var pos:Vector2
var rota:float
var dir:float
var speed=1000
var damage: int = gamedata.enemy_damage()/2

#funcion que consigue la posicion y rotacion global + destruye bala si existio por 3 segundos
func _ready():
	damage = gamedata.damage
	global_position=pos
	global_rotation=rota
	await get_tree().create_timer(3.7).timeout
	queue_free()
	
	#funcion que ajusta la velocidad de la bala teniendo en cuenta su rotacion (_physics_process se ejecuta cada frame)
func _physics_process(_delta):
	velocity=Vector2(speed,0).rotated(dir)
	move_and_slide()

func _on_area_2d_body_entered(body):
	
	if body.is_in_group("personaje"):
		
		if body.health > 0:
			body.health -= damage
			var direction = (body.global_position - global_position).normalized()
			body.velocity += direction * 1000
			await get_tree().create_timer(1.00).timeout #tiempo de invulnerabilidad del jugador

	
