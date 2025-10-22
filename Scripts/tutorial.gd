extends 'res://Scripts/dificultad.gd'

# Esta funcion se pregunta si tuto es true entonces directamente ignora el tutorial, si no, muestra el tutorial
func _ready():
	if gamedata.tuto == true:
		mundo()
	else:
		pass

func _on_button_pressed() -> void:
	gamedata.tuto = true
	mundo()
