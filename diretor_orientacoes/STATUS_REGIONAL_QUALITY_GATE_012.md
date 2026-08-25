# STATUS CHECKPOINT — REGIONAL QUALITY GATE 012

**Branch:** `integration/r1-r6-sprint1`  
**Coordenação:** Dev1  
**Data:** 25 de agosto de 2026

## Entrega

Foi criada a porta de qualidade reutilizável `tools/qa/run_regional_gate.sh`. Ela permite que cada responsável por região execute o mesmo conjunto de validações antes de solicitar merge para a branch comum.

| Etapa | Verificação |
|---|---|
| 1 | `git diff --check` contra a base de integração |
| 2 | Auditoria de alterações em ficheiros transversais sensíveis |
| 3 | Parser headless do Godot 4 |
| 4 | Contratos R1–R6 e rotas QA da região |

A documentação operacional está em `qa/regions/REGIONAL_QUALITY_GATE.md`.

## Resultado de validação na base comum

| Região | Rotas aprovadas |
|---|---|
| R3 | `road_to_arch`, `arch_to_forest` |
| R4 | `arch_to_forest`, `forest_to_majestic`, `forest_to_ruins` |
| R5 | `forest_to_majestic`, `majestic_to_lake` |
| R6 | `forest_to_ruins`, `majestic_to_lake`, `ruins_arrival` |

Todas as portas passaram na base atual. Isto confirma que os pontos de partida entregues a Dev3–Dev6 possuem parser, contratos e rotas técnicas estáveis antes de receberem conteúdo novo.

## Limite da validação

A porta não substitui inspeção artística em GPU. Cada região ainda precisa de uma passagem visual em OpenGL Compatibility antes de ser considerada aprovada para o jogo final.
