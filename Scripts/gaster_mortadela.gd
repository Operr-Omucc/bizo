extends StaticBody2D

@onready var target_nodes : Array
@onready var r_m_path = preload("res://Escenas/rayo_mortadlea.tscn")

var cont : bool = false
var target : Node2D
var lugar : Vector2
var rotar : bool = true

func _ready() -> void:
	# Buscar al personaje
	lugar = global_position
	
	print(">>> READY: lugar =", lugar, " target =", target)
	
	# Empezar el ciclo de disparo
	


func _physics_process(_delta: float) -> void:
	if target == null:
		target_nodes = get_tree().get_nodes_in_group("personaje")
		if target_nodes.size() > 0:
			target = target_nodes[0]  # Tomamos el primero
			$TimerDisparo.start()
	
	if target and target.is_inside_tree() and rotar:
		look_at(target.global_position) 


func _on_timer_timeout() -> void:
	if target == null or !target.is_inside_tree():
		print(">>> No hay target, no disparo")
		return
	
	print(">>> DISPARO!")
	var rayo_m = r_m_path.instantiate()
	rayo_m.add_to_group("rayo")
	rayo_m.position = global_position   # OJO: usar posición actual, no `lugar`
	rayo_m.rotation = rotation + deg_to_rad(180)
	get_parent().get_parent().add_child(rayo_m)      # más seguro que subir 2 padres
	
