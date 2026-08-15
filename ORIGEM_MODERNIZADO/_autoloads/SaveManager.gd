## SaveManager.gd
## Sistema de Save/Load do jogo ORIGEM.
## Guarda e carrega o estado do jogo usando ficheiros JSON.
## Todos os nós que queiram ser guardados devem estar no grupo "Persist"
## e implementar as funções `save_data() -> Dictionary` e `load_data(data: Dictionary)`.
## Parte do módulo: Core / Save

extends Node

# ============================================================
# CONSTANTES
# ============================================================

const SAVE_DIR: String = "user://saves/"
const SAVE_EXTENSION: String = ".origem"
const MAX_SAVE_SLOTS: int = 3

# ============================================================
# FUNÇÕES PÚBLICAS
# ============================================================

## Guarda o jogo no slot indicado (0, 1 ou 2).
func save_game(slot: int = 0) -> void:
	var save_data: Dictionary = _collect_save_data()
	var file_path: String = _get_save_path(slot)

	# Garante que a pasta de saves existe
	DirAccess.make_dir_recursive_absolute(SAVE_DIR)

	var file := FileAccess.open(file_path, FileAccess.WRITE)
	if file == null:
		push_error("[SaveManager] Erro ao abrir ficheiro para escrita: " + file_path)
		return

	file.store_string(JSON.stringify(save_data, "\t"))
	file.close()

	EventBus.game_saved.emit()
	print("[SaveManager] Jogo guardado no slot %d: %s" % [slot, file_path])

## Carrega o jogo do slot indicado.
func load_game(slot: int = 0) -> bool:
	var file_path: String = _get_save_path(slot)

	if not FileAccess.file_exists(file_path):
		push_warning("[SaveManager] Ficheiro de save não encontrado: " + file_path)
		return false

	var file := FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		push_error("[SaveManager] Erro ao abrir ficheiro para leitura: " + file_path)
		return false

	var json_string: String = file.get_as_text()
	file.close()

	var json := JSON.new()
	var parse_result: int = json.parse(json_string)
	if parse_result != OK:
		push_error("[SaveManager] Erro ao fazer parse do JSON: " + json.get_error_message())
		return false

	_apply_save_data(json.data)
	EventBus.game_loaded.emit()
	print("[SaveManager] Jogo carregado do slot %d" % slot)
	return true

## Verifica se existe um save no slot indicado.
func has_save(slot: int = 0) -> bool:
	return FileAccess.file_exists(_get_save_path(slot))

## Apaga o save do slot indicado.
func delete_save(slot: int = 0) -> void:
	var file_path: String = _get_save_path(slot)
	if FileAccess.file_exists(file_path):
		DirAccess.remove_absolute(file_path)
		print("[SaveManager] Save do slot %d apagado." % slot)

# ============================================================
# FUNÇÕES PRIVADAS
# ============================================================

## Recolhe os dados de todos os nós no grupo "Persist".
func _collect_save_data() -> Dictionary:
	var data: Dictionary = {}

	# Dados globais do GameManager
	data["game_manager"] = {
		"current_era": GameManager.current_era,
		"player_name": GameManager.player_name,
		"play_time": GameManager.play_time
	}

	# Dados de cada nó persistente na cena atual
	data["nodes"] = {}
	var persist_nodes := get_tree().get_nodes_in_group("Persist")
	for node in persist_nodes:
		if node.has_method("save_data"):
			data["nodes"][node.name] = node.save_data()

	return data

## Aplica os dados carregados a todos os nós no grupo "Persist".
func _apply_save_data(data: Dictionary) -> void:
	# Restaura dados globais
	if data.has("game_manager"):
		var gm_data: Dictionary = data["game_manager"]
		GameManager.current_era = gm_data.get("current_era", 0)
		GameManager.player_name = gm_data.get("player_name", "Explorador")
		GameManager.play_time = gm_data.get("play_time", 0.0)

	# Restaura dados dos nós
	if data.has("nodes"):
		var persist_nodes := get_tree().get_nodes_in_group("Persist")
		for node in persist_nodes:
			if node.has_method("load_data") and data["nodes"].has(node.name):
				node.load_data(data["nodes"][node.name])

## Retorna o caminho completo do ficheiro de save para um slot.
func _get_save_path(slot: int) -> String:
	return SAVE_DIR + "save_slot_%d%s" % [slot, SAVE_EXTENSION]
