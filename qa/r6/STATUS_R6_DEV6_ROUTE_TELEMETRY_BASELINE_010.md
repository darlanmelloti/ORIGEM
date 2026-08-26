# ORIGEM — DEV6-R6-ROUTE-TELEMETRY-BASELINE-010

**Estado:** concluída localmente
**Responsável:** dev6
**Âmbito exclusivo:** R6 — Ruínas Submersas

## Entrega

Foram adicionados `qa/r6/route_telemetry_baseline.tsv` e `tools/qa/verify_r6_route_telemetry_baseline.sh`. A baseline versiona os nove campos numéricos de spawn, alvo, delta e distância das três rotas R6. A verificação usa tolerância padrão de `0,050 m`, rejeita rota ausente, rota inesperada, vetor inválido ou desvio superior ao limite.

## Verificações

| Caso | Resultado |
|---|---|
| Telemetria atual contra baseline | Três rotas aprovadas com `max_delta=0,000 m` |
| Desvio controlado de `0,200 m` em `ruins_arrival` | Rejeitado corretamente |
| Sintaxe Bash | Aprovada |
| Parser Godot 4.7.1 | Aprovado |
| Orçamento R6 | Quatro luzes aprovado |
| Handoff R6→R7 | Aprovado |
| Rotas R6 | `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival` aprovadas |

## Próxima tarefa ACTIVE

`DEV6-R6-ROUTE-REGRESSION-PIPELINE-011`: criar um único orquestrador QA que execute captura de matriz, extração de telemetria e verificação de baseline numa sequência reprodutível. A tarefa permanece estritamente QA; não pode alterar produção, câmera, água, luzes, shaders, emissão, colisores, handoff ou R7.
