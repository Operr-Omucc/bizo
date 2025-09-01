extends CharacterBody2D

var pos: Vector2
var rota: float   # ángulo en radianes (te lo pasa el martillo)
var dir: Vector2  # vector dirección
var speed: float = 2000
var damage: int = gamedata.damage

func _ready():
	add_to_group("bala")
	damage = gamedata.damage
	global_position = pos
	global_rotation = rota
	
	# Si no se asignó dir desde afuera, calcularlo desde rota
	if dir == Vector2.ZERO or dir == null:
		dir = Vector2.RIGHT.rotated(rota)
	else:
		dir = dir.normalized()
	
	# Autodestruirse después de 0.7s
	await get_tree().create_timer(0.7).timeout
	queue_free()

func _physics_process(_delta: float) -> void:
	velocity = dir * speed
	move_and_slide()
