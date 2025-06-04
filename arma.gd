extends CharacterBody2D
var bullet_path=preload("res://Escenas/bala.tscn")
func _physics_process(_delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Click"):
		fire()
		
func fire():
	var bullet=bullet_path.instantiate()
	bullet.dir=rotation
	bullet.pos=$Node2D.global_position
	bullet.rota=global_rotation
	get_parent().add_child(bullet)
