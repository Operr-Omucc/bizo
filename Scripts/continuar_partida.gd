extends Node

# ✅ Singleton global "gamedata"
var save_path := "user://guardar_partida.save"

# 🧩 Construye un diccionario con los valores actuales del jugador
func get_game_data() -> Dictionary:
	return {
		# Guardamos rutas de escenas (si no hay escena, queda string vacío)
		"personaje": gamedata.chara_Scene.resource_path if gamedata.chara_Scene != null else "",
		"mano": gamedata.arm_scene.resource_path if gamedata.arm_scene != null else "",
		"arma": gamedata.gun_scene.resource_path if gamedata.gun_scene != null else "",


		# Datos simples
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

# 💾 Guardar partida
func save_game() -> void:
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	if not save_file:
		push_error("❌ No se pudo abrir archivo para guardar: %s" % save_path)
		return

	var data = get_game_data()
	save_file.store_var(data)
	save_file.close()
	print("✅ Partida guardada en:", save_path)

# 📂 Cargar partida
func load_game() -> void:
	if not FileAccess.file_exists(save_path):
		print("⚠ No existe archivo de guardado en:", save_path)
		return

	var save_file = FileAccess.open(save_path, FileAccess.READ)
	if not save_file:
		push_error("❌ No se pudo abrir archivo para leer: %s" % save_path)
		return

	var loaded_data = save_file.get_var()
	save_file.close()

	if typeof(loaded_data) != TYPE_DICTIONARY:
		push_error("❌ Error: el archivo no contiene un diccionario válido.")
		return

	# 🔁 Cargar escenas de rutas (si existe y no es string vacío)
	if loaded_data.has("personaje") and typeof(loaded_data["personaje"]) == TYPE_STRING and loaded_data["personaje"] != "":
		var p = load(loaded_data["personaje"])
		gamedata.chara_Scene = p if p is PackedScene else null
	else:
		gamedata.chara_Scene = null

	if loaded_data.has("mano") and typeof(loaded_data["mano"]) == TYPE_STRING and loaded_data["mano"] != "":
		var p2 = load(loaded_data["mano"])
		gamedata.arm_scene = p2 if p2 is PackedScene else null
	else:
		gamedata.arm_scene = null

	if loaded_data.has("arma") and typeof(loaded_data["arma"]) == TYPE_STRING and loaded_data["arma"] != "":
		var p3 = load(loaded_data["arma"])
		gamedata.gun_scene = p3 if p3 is PackedScene else null
	else:
		gamedata.gun_scene = null

	# 🔁 Variables numéricas
	gamedata.money_amount = int(loaded_data.get("dinero", 0))
	gamedata.maxHealth = int(loaded_data.get("vidaMax", 0))
	gamedata.health = int(loaded_data.get("vida", 0))
	gamedata.damage = int(loaded_data.get("daño", 0))
	gamedata.speed = int(loaded_data.get("velocidad", 0))
	gamedata.fire_rate = float(loaded_data.get("fire_rate", 1.0))
	gamedata.armor = int(loaded_data.get("armadura", 0))

	# 🔁 Variables booleanas
	gamedata.zona = bool(loaded_data.get("zona", false))
	gamedata.tuto = bool(loaded_data.get("tuto", false))

	print("✅ Partida cargada desde:", save_path)
