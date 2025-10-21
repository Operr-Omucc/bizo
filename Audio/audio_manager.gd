extends Node2D

# Variable booleana que revisa si el juego esta muteado/silenciado para silenciar otros sonidos
@export var mute: bool = false

# En general las funciones a continuacion estan encargadas de sonidos simples como golpes, disparos o rayos
# Hasta de controlar la musica e incluso reproducir la voz del tipo de la tienda, este script no
# Tiene mucho mas proposito que sonidos/musica

func play_golpe():
	if not mute:
		$golpe.play()

func play_disparo():
	if not mute:
		$disparo.play()

func play_victoria():
	if not mute:
		$juego.stop()
		$victoria.play()

func play_derrota():
	if not mute:
		$juego.stop()
		$derrota.play()
		
func play_rayo():
	if not mute:
		$rayo.play()
		
func play_hombreTienda():
	if not mute:
			if $hombreTienda.playing:
				$hombreTienda.stop()
			else:
				$hombreTienda.play()

func play_tienda():
	if not mute:
		$tienda.play()
	
func play_juego():
	if not mute:
		$juego.play()

func stop_tienda():
	if not mute:
		$tienda.stop()

func stop_juego():
	if not mute:
		$juego.stop()

func _on_tienda_finished() -> void:
	if not mute:
		$tienda.play()


func _on_juego_finished() -> void:
	if not mute:
		$juego.play()
