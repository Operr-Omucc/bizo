extends StaticBody2D

@onready var target = get_tree().get_nodes_in_group("personaje")[0]

func _physics_process(_delta: float) -> void:
	if target and target.is_inside_tree():
		var pos = target.global_position
		look_at(pos)
