extends 'res://Scripts/dificultad.gd'

func _ready():
	if gamedata.tuto == true:
		mundo()
	else:
		pass

func _on_button_pressed() -> void:
	gamedata.tuto = true
	mundo()
