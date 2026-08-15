## QuestData.gd
## Define a estrutura de dados de uma missão do jogo ORIGEM.
## Usar como Custom Resource (.tres) para criar missões no Inspector do Godot.
## Parte do módulo: Core / Quests


extends Resource

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
# CLASSE INTERNA: OBJETIVO DE MISSÃO
# ============================================================

class QuestObjective extends Resource:
	@export var id: String = ""
	@export var description: String = ""
	@export var required_amount: int = 1
	var current_amount: int = 0

	func is_complete() -> bool:
		return current_amount >= required_amount

# ============================================================
# PROPRIEDADES EXPORTADAS
# ============================================================

@export var id: String = ""
@export var title: String = ""
@export var description: String = ""
@export var era: String = ""
@export var objectives: Array[QuestObjective] = []
@export var reward_items: Array[ItemData] = []
@export var reward_experience: int = 0

## Se verdadeiro, esta missão afeta a Timeline do jogo.
@export var affects_timeline: bool = false
@export var timeline_consequence: String = ""

# ============================================================
# VARIÁVEIS DE ESTADO (não exportadas — geridas pelo QuestManager)
# ============================================================

var status: QuestStatus = QuestStatus.NOT_STARTED

# ============================================================
# FUNÇÕES PÚBLICAS
# ============================================================

## Verifica se todos os objetivos da missão estão completos.
func all_objectives_complete() -> bool:
	for objective in objectives:
		if not objective.is_complete():
			return false
	return true
