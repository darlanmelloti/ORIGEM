# STATUS CHECKPOINT 350 — Dev6 R6: handoff físico para R7

**Data:** 2026-08-26
**Região:** R6 — Ruínas Submersas
**Branch canónica:** `dev6/r6-submerged-ruins`

## Entrega aprovada

`DEV6-R6-SHORE-HANDOFF-002` instala o módulo isolado `R6ShoreHandoff.gd` e monta a continuidade física a norte/nordeste da margem R6. A entrega inclui quatro lajes de pedra, cada uma com colisor explícito, e dois marcos arqueológicos assimétricos. Os elementos continuam no AABB R6 e não constroem a Vila Elevada ou qualquer conteúdo de R7.

## Provas concluídas

| Prova | Resultado |
|---|---|
| Parser Godot 4.7.1 | Aprovado |
| Handoff | `[ORIGEM_R6_HANDOFF_OK]` |
| Orçamento R6 | `world=2`, `lake_omni=2`, `lake_spot=0`, `r6_total=4` |
| Porta R6 | Aprovada com a nova prova obrigatória |
| Rotas | `forest_to_ruins`, `majestic_to_lake`, `ruins_arrival` aprovadas |
| Regressão R5 | Porta R5 aprovada no estado R5–R6 reconciliado |

## Continuidade

O contrato foi avançado para `DEV6-R6-WATERLINE-READING-003` em estado `ACTIVE`. A próxima entrega reforça a leitura da linha de água por geometria assimétrica, sem luz, shader adicional, painel ou bloqueio no caminho jogável.
