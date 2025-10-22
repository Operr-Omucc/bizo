class_name Hombro
extends Node2D

func _physics_process(_delta: float) -> void:
	# Lo unico que hace esto es revisar donde esta el mouse 
	look_at(get_global_mouse_position())
