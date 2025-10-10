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
				
##extends Node

##var save_path = "user://guardar_partida.json"

##func save_game() -> void:
	##var save_file = FileAccess.open(save_path, FileAccess.WRITE)
##	if save_file:
##		# Guardamos las rutas de las PackedScene en vez de los objetos
##		var game_data = {
##			"personaje": gamedata.chara_Scene.resource_path,
##			"mano": gamedata.arm_scene.resource_path,
##			"arma": gamedata.gun_scene.resource_path,
##			"dinero": gamedata.money_amount,
##			"vidaMax": gamedata.maxHealth,
##			"vida": gamedata.health,
##			"daño": gamedata.damage,
##			"velocidad": gamedata.speed,
##			"fire_rate": gamedata.fire_rate,
##			"armadura": gamedata.armor,
##			"zona": gamedata.zona
##		}
##		
##		# Puedes usar JSON o store_var, ambos funcionarán con texto
##		save_file.store_var(game_data)
##		print("✅ Partida guardada correctamente:", save_path)
##	else:
##		print("❌ No se pudo abrir el archivo para guardar.")
##
##func load_game() -> void:
	##if FileAccess.file_exists(save_path):
	##	var save_file = FileAccess.open(save_path, FileAccess.READ)
	##	if save_file:
##			var loaded_data = save_file.get_var()
##			if typeof(loaded_data) == TYPE_DICTIONARY:
##				# Cargar las rutas y convertirlas de nuevo en PackedScenes
##				gamedata.chara_Scene = load(loaded_data["personaje"])
##				gamedata.arm_scene = load(loaded_data["mano"])
##				gamedata.gun_scene = load(loaded_data["arma"])
##				gamedata.money_amount = loaded_data["dinero"]
##				gamedata.maxHealth = loaded_data["vidaMax"]
##				gamedata.health = loaded_data["vida"]
##				gamedata.damage = loaded_data["daño"]
##				gamedata.speed = loaded_data["velocidad"]
##				gamedata.fire_rate = loaded_data["fire_rate"]
##				gamedata.armor = loaded_data["armadura"]
##				gamedata.zona = loaded_data["zona"]
##				print("✅ Partida cargada con éxito.")
##			else:
##				print("❌ Error: el archivo no contiene un diccionario válido.")
##	else:
##		print("⚠️ No existe archivo de guardado.")
##
########
