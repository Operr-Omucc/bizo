class_name Brazo
extends Node2D

@onready var puño = $"Hombro/Sprite2D/Puño"
@onready var animacion_golpe = $"Hombro/Sprite2D/Puño/AnimationPlayer"
var posicion_original: Vector2
var puede_golpear := false
var puede_dañar := false

func _ready():
	await get_tree().process_frame
	posicion_original = puño.position

func _physics_process(_delta):
	if Input.is_action_just_pressed("Brazo"):
		golpear()

func golpear():
	animacion_golpe.play("Golpe", 0.0, 3.0)
	puede_golpear = true
	puño.damage = 20

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Golpe":
		puño.position = posicion_original
		puede_golpear = false
		puño.damage = 0
