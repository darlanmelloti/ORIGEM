## EventBus.gd
## Sistema global de comunicação por sinais entre módulos desacoplados.
## Todos os sistemas do jogo comunicam através deste Autoload.
## Parte do módulo: Core / Framework

extends Node

# ============================================================
# SINAIS DO JOGADOR
# ============================================================

## Emitido quando a vida do jogador muda. Usado pela UI do HUD.
signal player_health_changed(current_health: int, max_health: int)

## Emitido quando a stamina do jogador muda. Usado pelo HUD de combate.
signal player_stamina_changed(current_stamina: float, max_stamina: float)

## Emitido quando o jogador morre.
signal player_died()

## Emitido quando o jogador entra numa nova área/zona.
signal player_entered_area(area_name: String)

## Emitido quando o jogador interage com um objeto (nome do nó interativo).
signal player_interacted(object_name: String)

## Emitido quando o alvo de interação do jogador muda (para UI do HUD).
signal player_interact_target_changed(has_target: bool, object_name: String)

## Emitido quando o jogador solicita uma mensagem na UI (texto, duração).
signal player_message_requested(text: String, duration: float)

# ============================================================
# SINAIS DE INIMIGOS
# ============================================================

# ============================================================
# SINAIS DE INVENTÁRIO
# ============================================================

## Emitido quando um item é adicionado ao inventário.
signal item_added(item_data: Resource)

## Emitido quando um item é removido do inventário.
signal item_removed(item_id: String)

## Emitido quando o inventário é aberto ou fechado.
signal inventory_toggled(is_open: bool)

# ============================================================
# SINAIS DE MISSÕES (QUESTS)
# ============================================================

## Emitido quando uma nova missão começa.
signal quest_started(quest_id: String)

## Emitido quando um objetivo de missão é atualizado.
signal quest_objective_updated(quest_id: String, objective_id: String, current: int, required: int)

## Emitido quando uma missão é completada.
signal quest_completed(quest_id: String)

# ============================================================
# SINAIS DE TIMELINE (CONSEQUÊNCIAS TEMPORAIS)
# ============================================================

## Emitido quando o jogador viaja no tempo ou muda de era.
signal timeline_era_changed(from_era: String, to_era: String)

## Emitido quando uma ação do jogador cria uma consequência temporal.
signal timeline_event_triggered(event_id: String, era: String)

## Emitido quando o Chronos aplica um perfil de atmosfera e bioma a uma era.
signal chronos_profile_changed(profile_id: String, profile_data: Dictionary)

## Emitido no início de uma transição temporal, antes da alteração visual.
signal chronos_transition_started(from_profile: String, to_profile: String)

# ============================================================
# SINAIS DE DIÁLOGO E NPCs
# ============================================================

## Emitido quando um diálogo começa com um NPC.
signal dialogue_started(npc_id: String)

## Emitido quando um diálogo termina.
signal dialogue_ended(npc_id: String)

# ============================================================
# SINAIS DE JOGO GLOBAL
# ============================================================

## Emitido quando o jogo é pausado ou retomado.
signal game_paused(is_paused: bool)

## Emitido quando uma cena é carregada com sucesso.
signal scene_loaded(scene_name: String)

## Emitido quando o jogo é guardado.
signal game_saved()

## Emitido quando o jogo é carregado.
signal game_loaded()

# ============================================================
# SINAIS DE EVENTOS DO MUNDO
# ============================================================

## Emitido quando um evento global do mundo é acionado.
signal world_event_triggered(event_id: String)
