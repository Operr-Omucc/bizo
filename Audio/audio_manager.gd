extends Node2D

@export var mute: bool = false

func _ready() -> void:
	if not mute:
		play_musica()

func play_golpe():
	if not mute:
		$golpe.play()
		
func play_musica():
	if not mute:
		$musica.play()

func play_disparo():
	if not mute:
		$disparo.play()

func play_victoria():
	if not mute:
		$musica.stop()
		$victoria.play()

func play_derrota():
	if not mute:
		$musica.stop()
		$derrota.play()
		
func play_rayo():
	if not mute:
		$rayo.play()
