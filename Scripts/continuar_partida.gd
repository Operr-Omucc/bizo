extends Node

# Variable que declara donde se guarda la partida
var save_path = "res://guardar_partida.txt"

# Diccionario de los stats del jugador
var game_data : Dictionary = {
	"personaje": gamedata.chara_Scene,
	"mano": gamedata.arm_scene,
	"arma": gamedata.gun_scene,
	"dinero": gamedata.money_amount,
	"vidaMax": gamedata.maxHealth,
	"vida": gamedata.health,
	"daño": gamedata.damage,
	"velocidad": gamedata.speed,
	"fire_rate": gamedata.fire_rate,
	"armadura": gamedata.armor,
	"zona": gamedata.zona,
	"tuto": gamedata.tuto
}

# Funcion para guardar la partida
func save_game() -> void:
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	if save_file:
		save_file.store_var(game_data)

# Funcion para cargar la partida
func load_game() -> void:
	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path, FileAccess.READ)
		if save_file:
			var loaded_data = save_file.get_var()
			if typeof(loaded_data) == TYPE_DICTIONARY:
				game_data = loaded_data
			else:
				print("Error: Loaded data is not a dictionary.")
				
