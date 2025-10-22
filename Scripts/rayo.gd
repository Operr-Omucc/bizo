extends Node2D

# Variables de la posicion, rotacion y direccion del rayo
var pos: Vector2
var rota: float   
var dir: Vector2

# Variables del daño y duracion del rayo
@export var damage: int = gamedata.damage+100
@export var duration: float = 1.5

# Funcion para preparar al rayo cuando va a ser disparado, lo añade al grupo bala para que el
# Enemigo lo detecte bien, establece la posicion global y rotacion dependiendo de las dos
# Variables que estan ahí arriba
func _ready():
	# Timer de duración
	add_to_group("bala")
	$Area2D.add_to_group("bala")
	$Area2D.damage = damage
	global_position = pos
	global_rotation = rota
	
	# Si no se asignó dir desde afuera, calcularlo desde rota
	if dir == Vector2.ZERO or dir == null:
		dir = Vector2.RIGHT.rotated(rota)
	else:
		dir = dir.normalized()
	
	await get_tree().create_timer(duration).timeout
	queue_free()
