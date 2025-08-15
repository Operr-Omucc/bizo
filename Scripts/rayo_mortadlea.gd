extends Node2D


@onready var target = get_tree().get_nodes_in_group("personaje")[0]

var damage = 20


func _on_area_2d_body_entered(body):
	if body.is_in_group(target):
		
		if body.health > 0:
			body.health -= damage
			await get_tree().create_timer(2.00).timeout #tiempo de invulnerabilidad del jugador
			
			
		elif body.health < 1:
			get_tree().call_deferred("change_scene_to_file","res://Escenas/main_menu.tscn")
			
