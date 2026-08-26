# ORIGEM — DEV6-R6-CAPTURE-MATRIX-008

**Estado:** concluída localmente
**Responsável:** dev6
**Âmbito exclusivo:** R6 — Ruínas Submersas

## Entrega

A sonda `capture_r6_arrival_runtime.sh` passou a aceitar as rotas R6 e aguardar o marcador de spawn específico. O orquestrador `capture_r6_route_matrix.sh` executa `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival`, produzindo captura 1600×900 e inventário de composição para cada rota.

## Matriz validada

| Rota | Spawn confirmado | Captura | Composição R6 |
|---|---|---|---|
| `forest_to_ruins` | Sim | 1600×900 | Água, estela, 9 detritos, 3 vestígios, domo, 8 pilares, 3 marcos, 0 luzes e 0 colisores |
| `majestic_to_lake` | Sim | 1600×900 | Água, estela, 9 detritos, 3 vestígios, domo, 8 pilares, 3 marcos, 0 luzes e 0 colisores |
| `ruins_arrival` | Sim | 1600×900 | Água, estela, 9 detritos, 3 vestígios, domo, 8 pilares, 3 marcos, 0 luzes e 0 colisores |

A execução final aprovou sintaxe Bash, parser Godot 4.7.1, orçamento de quatro luzes, handoff R6→R7 e as três rotas obrigatórias. As capturas servem como evidência QA e não foram adicionadas ao repositório.

## Próxima tarefa ACTIVE

`DEV6-R6-ROUTE-TARGET-TELEMETRY-009`: criar uma sonda QA que registre, por rota R6, o spawn, alvo e distância horizontal associados à telemetria runtime. A tarefa não pode alterar produção, câmera, água, luzes, shaders, emissão, colisores, handoff ou R7.
