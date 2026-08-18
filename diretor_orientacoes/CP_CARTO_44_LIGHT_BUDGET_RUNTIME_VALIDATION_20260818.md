# CP-CARTO-44 — Integridade do Limitador de Luzes

**Branch:** `feature/cine07-final`  
**Escopo:** `scripts/main.gd`, limitador adaptativo de OmniLights do mundo exterior.  
**Fronteira:** o orçamento efectivo de **16 OmniLights visíveis** não foi aumentado; não foram alteradas luzes, geometria, Regiões 7–12, combate ou rota física.

## Correcção

Uma sonda de QA revelou que `_apply_exterior_light_budget()` podia receber `current_scene == null` durante uma instanciação técnica, propagando uma referência nula até `_collect_lights_recursive()`. Foi adicionada uma origem alternativa segura (`SceneTree.root`) e uma guarda de validade no início da recursão. O algoritmo de recolha, ordenação por distância e limite de luzes permanece inalterado.

| Critério | Resultado |
| --- | --- |
| Godot 4.7.1 headless | **Aprovado** |
| Harness técnico com cena corrente indisponível | **Aprovado; sem erro de referência nula** |
| Menu principal | **Aprovado** |
| Novo Jogo | **Aprovado** |
| Gameplay real pós-Novo Jogo | **30 segundos aprovados, sem erro de script** |
| Captura 1600×900 | `/home/ubuntu/qa_evidence_voss_vista/cp_carto44_menu_newgame_1600x900.png` |
| Limite de luzes | **Preservado: 16 OmniLights** |

## Continuidade

A correcção CP-CARTO-44 remove uma falha real de runtime e mantém a validação do pacote de entrada limpa. A próxima lacuna de polimento permanece na leitura da bacia R6; os ensaios de relva e de material dos fetos foram rejeitados e não foram incluídos neste checkpoint.
