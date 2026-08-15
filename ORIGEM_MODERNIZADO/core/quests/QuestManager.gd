## QuestManager.gd
## Gestor central de missões do ORIGEM.
## Controla o estado de todas as missões, objetivos e fases narrativas.
## Deve ser registado como Autoload: Projeto > Globais > Carregamento Automático
## Parte do módulo: Core / Quests


extends Node

# ============================================================
# ENUMERAÇÕES
# ============================================================

enum QuestStatus {
	NOT_STARTED,
	ACTIVE,
	COMPLETED,
	FAILED
}

# ============================================================
# DADOS DAS MISSÕES (definição estática)
# ============================================================

## Estrutura de cada missão: { id, title, description, objectives: [{id, desc, required}] }
const QUEST_DEFINITIONS: Dictionary = {
	"main_01_awakening": {
		"title": "O Despertar de Elias",
		"description": "Elias Voss acordou com memórias que não são suas. Uma voz guia-o para encontrar os fragmentos.",
		"era": "modern",
		"objectives": [
			{ "id": "contact_seraph", "description": "Contactar o Terminal P-52 (Seraph)", "required": 1 },
			{ "id": "find_tablets", "description": "Recolher as 3 Tábuas de Tradução", "required": 3 },
		]
	},
	"main_02_orion_cube": {
		"title": "O Cubo de Orion",
		"description": "Com os três fragmentos reunidos, Elias deve ativar o Cubo de Orion antes que o Guardião o impeça.",
		"era": "modern",
		"objectives": [
			{ "id": "activate_cube", "description": "Ativar o Cubo de Orion", "required": 1 },
			{ "id": "escape_guardian", "description": "Escapar através da porta temporal", "required": 1 },
		]
	},
}

# ============================================================
# ESTADO DAS MISSÕES (dinâmico, guardado no save)
# ============================================================

## { quest_id: QuestStatus }
var quest_status: Dictionary = {}

## { quest_id: { objective_id: current_count } }
var objective_progress: Dictionary = {}

# ============================================================
# CICLO DE VIDA
# ============================================================

func _ready() -> void:
	# Inicializa todas as missões como NOT_STARTED
	for quest_id in QUEST_DEFINITIONS:
		quest_status[quest_id] = QuestStatus.NOT_STARTED
		objective_progress[quest_id] = {}
		for obj in QUEST_DEFINITIONS[quest_id]["objectives"]:
			objective_progress[quest_id][obj["id"]] = 0

	# Ouve o EventBus para atualizar missões automaticamente
	EventBus.item_added.connect(_on_item_added)

# ============================================================
# FUNÇÕES PÚBLICAS
# ============================================================

## Inicia uma missão pelo seu ID.
func start_quest(quest_id: String) -> void:
	if not QUEST_DEFINITIONS.has(quest_id):
		push_warning("[QuestManager] Missão não encontrada: " + quest_id)
		return
	if quest_status[quest_id] != QuestStatus.NOT_STARTED:
		return
	quest_status[quest_id] = QuestStatus.ACTIVE
	EventBus.quest_started.emit(quest_id)
	print("[QuestManager] Missão iniciada: %s" % QUEST_DEFINITIONS[quest_id]["title"])

## Avança o progresso de um objetivo específico.
func advance_objective(quest_id: String, objective_id: String, amount: int = 1) -> void:
	if quest_status.get(quest_id) != QuestStatus.ACTIVE:
		return

	var progress: Dictionary = objective_progress[quest_id]
	if not progress.has(objective_id):
		return

	# Encontra o objetivo para saber o valor máximo
	var required := 1
	for obj in QUEST_DEFINITIONS[quest_id]["objectives"]:
		if obj["id"] == objective_id:
			required = obj["required"]
			break

	progress[objective_id] = min(progress[objective_id] + amount, required)
	EventBus.quest_objective_updated.emit(quest_id, objective_id, progress[objective_id], required)
	print("[QuestManager] Objetivo '%s' → %d/%d" % [objective_id, progress[objective_id], required])

	# Verifica se a missão foi completada
	_check_quest_completion(quest_id)

## Verifica se um objetivo está completo.
func is_objective_complete(quest_id: String, objective_id: String) -> bool:
	if not objective_progress.has(quest_id):
		return false
	var progress: Dictionary = objective_progress[quest_id]
	if not progress.has(objective_id):
		return false
	for obj in QUEST_DEFINITIONS[quest_id]["objectives"]:
		if obj["id"] == objective_id:
			return progress[objective_id] >= obj["required"]
	return false

## Retorna o estado de uma missão.
func get_quest_status(quest_id: String) -> QuestStatus:
	return quest_status.get(quest_id, QuestStatus.NOT_STARTED)

## Retorna o título de uma missão.
func get_quest_title(quest_id: String) -> String:
	return QUEST_DEFINITIONS.get(quest_id, {}).get("title", "")

# ============================================================
# SAVE / LOAD
# ============================================================

func save_data() -> Dictionary:
	return {
		"quest_status": quest_status.duplicate(),
		"objective_progress": objective_progress.duplicate(true)
	}

func load_data(data: Dictionary) -> void:
	quest_status = data.get("quest_status", {})
	objective_progress = data.get("objective_progress", {})

# ============================================================
# CALLBACKS DO EVENTBUS
# ============================================================

func _on_item_added(item_id: String) -> void:
	# Quando uma tábua é adicionada, avança o objetivo da missão principal
	if item_id.begins_with("tablet_"):
		advance_objective("main_01_awakening", "find_tablets")

# ============================================================
# FUNÇÕES PRIVADAS
# ============================================================

func _check_quest_completion(quest_id: String) -> void:
	var all_done := true
	for obj in QUEST_DEFINITIONS[quest_id]["objectives"]:
		if not is_objective_complete(quest_id, obj["id"]):
			all_done = false
			break

	if all_done:
		quest_status[quest_id] = QuestStatus.COMPLETED
		EventBus.quest_completed.emit(quest_id)
		print("[QuestManager] Missão COMPLETA: %s" % QUEST_DEFINITIONS[quest_id]["title"])
