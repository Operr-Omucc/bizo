extends CharacterBody2D
var pos:Vector2
var rota:float
var dir:float
var speed=2000
var damage: int

#funcion que consigue la posicion y rotacion global + destruye bala si existio por 3 segundos
func _ready():
	global_position=pos
	global_rotation=rota
	await get_tree().create_timer(0.7).timeout
	queue_free()
	
	#funcion que ajusta la velocidad de la bala teniendo en cuenta su rotacion (_physics_process se ejecuta cada frame)
func _physics_process(_delta):
	velocity=Vector2(speed,0).rotated(dir)
	move_and_slide()
