# ORIGEM — DEV6-R6-ROUTE-TARGET-TELEMETRY-009

**Estado:** concluída localmente
**Responsável:** dev6
**Âmbito exclusivo:** R6 — Ruínas Submersas

## Entrega

Foi adicionado `tools/qa/extract_r6_route_telemetry.sh`. A sonda consome somente a telemetria já emitida pelos logs da matriz R6 e produz `route_telemetry.tsv` e `route_telemetry.md`, sem alterar o runtime, o spawn, o alvo ou a orientação de qualquer rota.

## Vetores confirmados

| Rota | Spawn `(x, y, z)` | Alvo `(x, y, z)` | Δx | Δz | Distância horizontal |
|---|---:|---:|---:|---:|---:|
| `forest_to_ruins` | `(9.765, 1.198, 194.000)` | `(14.000, 1.198, 225.000)` | `4.235` | `31.000` | `31.288 m` |
| `majestic_to_lake` | `(-77.400, 2.414, 178.000)` | `(7.330, 2.414, 186.000)` | `84.730` | `8.000` | `85.107 m` |
| `ruins_arrival` | `(13.679, 1.254, 222.000)` | `(54.000, 1.254, 252.000)` | `40.321` | `30.000` | `50.257 m` |

A sonda rejeita logs ausentes, formato de alvo inválido e vetores horizontais nulos. A sintaxe Bash, o parser Godot 4.7.1, o orçamento de quatro luzes, o handoff R6→R7 e as três rotas foram aprovados após a extração.

## Próxima tarefa ACTIVE

`DEV6-R6-ROUTE-TELEMETRY-BASELINE-010`: consolidar os três vetores aprovados como baseline QA versionada e criar uma verificação de desvio tolerante. A tarefa não pode alterar produção, câmera, água, luzes, shaders, emissão, colisores, handoff ou R7.
