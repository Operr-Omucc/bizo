extends Area2D


@onready var target = get_tree().get_nodes_in_group("personaje")
@onready var anim_advertir = $"../Sprite2D2/Play_Advertir"
@onready var anim_generar: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d_2: Sprite2D = $"../Sprite2D2"
var damage = 20

func _ready() -> void:
	self.add_to_group("rayo")
	scale.y = 0  # arranca invisible
	anim_advertir.play("advertir")
	anim_advertir.animation_finished.connect(_on_advertir_finished)
	anim_generar.animation_finished.connect(_on_generar_finished)

func _on_advertir_finished(anim_name: String) -> void:
	if anim_name == "advertir":
		sprite_2d_2.queue_free()
		anim_generar.play("generar_gm")

func _on_generar_finished(anim_name: String) -> void:
	if anim_name == "generar_gm":
		queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group(target):
		
		if body.health > 0:
			body.health -= damage
			await get_tree().create_timer(1.00).timeout #tiempo de invulnerabilidad del jugador
			
			
		elif body.health < 1:
			get_tree().call_deferred("change_scene_to_file","res://Escenas/main_menu.tscn")
	
	
