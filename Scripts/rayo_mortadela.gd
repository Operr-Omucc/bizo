extends Area2D

@onready var col_shape: CollisionShape2D = $"../Area2D/CollisionShape2D"
@onready var anim_advertir: AnimationPlayer = $"../Sprite2D2/Play_Advertir"
@onready var anim_generar: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d_2: Sprite2D = $"../Sprite2D2"

func _ready() -> void:
	self.add_to_group("rayo")
	col_shape.disabled = true
	scale.y = 0  # arranca invisible
	anim_advertir.animation_finished.connect(_on_advertir_finished)
	anim_generar.animation_finished.connect(_on_generar_finished)
	anim_advertir.play("advertir")

func _on_advertir_finished(anim_name: String) -> void:
	if anim_name == "advertir":
		sprite_2d_2.queue_free()
		col_shape.disabled = false
		anim_generar.play("generar_gm")

func _on_generar_finished(anim_name: String) -> void:
	if anim_name == "generar_gm":
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	var damage = 20
	if body.is_in_group("personaje"):
	
		if body.health > 0:
			body.health -= damage
			await get_tree().create_timer(1.00).timeout #tiempo de invulnerabilidad del jugador
		elif body.health < 1:
			gamedata.currentWave = 1
			get_tree().call_deferred("change_scene_to_file", "res://Escenas/main_menu.tscn")
