extends Node

var save_path = "res://guardar_partida.txt"

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
	"zona": gamedata.zona
}

func save_game() -> void:
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	if save_file:
		save_file.store_var(game_data)

func load_game() -> void:
	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path, FileAccess.READ)
		if save_file:
			var loaded_data = save_file.get_var()
			if typeof(loaded_data) == TYPE_DICTIONARY:
				game_data = loaded_data
			else:
				print("Error: Loaded data is not a dictionary.")
