extends Node2D

var pos: Vector2
var rota: float   
var dir: Vector2

@export var damage: int = gamedata.damage+100
@export var duration: float = 1.5
@export var width: float = 40.0

@onready var col_shape: CollisionShape2D = $Area2D/CollisionShape2D
@onready var area: Area2D = $Area2D
@onready var line: Line2D = $rayinio

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
#func fire(start_pos: Vector2, end_pos: Vector2):
	#if gamedata.damage <1:
		#gamedata.damage = damage
	## Posicionar rayo
	#global_position = start_pos
	## Dibujar línea
	#line.clear_points()
	#line.width = width
	#line.add_point(Vector2.ZERO)
	#line.add_point(end_pos - start_pos)
	#
	## Ajustar colisión del área
	#var shape := RectangleShape2D.new()
	#$Area2D/CollisionShape2D.shape = shape
	#$Area2D.position = (end_pos - start_pos) / 4
	#rotation = (end_pos - start_pos).angle()
	#shape.extents = Vector2((end_pos - start_pos).length()/2, width/2)
