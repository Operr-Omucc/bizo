extends StaticBody2D

@onready var r_m_path = preload("res://Escenas/rayo_mortadlea.tscn")
var lugar : Vector2
var rotar : bool

func _ready() -> void:
	lugar = global_position
	start_shooting()
	rotar = true

func _physics_process(_delta: float) -> void:
	var target = get_tree().get_nodes_in_group("personaje")[0]
	await get_tree().create_timer(3).timeout
	if target and target.is_inside_tree():
		if rotar == true:
			look_at(target.global_position)
			rotation += deg_to_rad(-180)

func start_shooting() -> void:
	await get_tree().create_timer(2).timeout
	var target = get_tree().get_nodes_in_group("personaje")
	if target == null:
		pass
	else:
		disparo()

func disparo():
	var target = get_tree().get_nodes_in_group("personaje")[0]
	if target == null:
		pass
	else:
		while target != null:
			var rayo_m = r_m_path.instantiate()
			rayo_m.add_to_group("rayo")
			rayo_m.position = lugar
			rayo_m.rotation = rotation
			rotar = false
			get_parent().get_parent().add_child(rayo_m)
			await get_tree().create_timer(3).timeout
			rotar = true
			await get_tree().create_timer(1).timeout
