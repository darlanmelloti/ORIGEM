# STATUS CHECKPOINT 360 — Dev6 R6: leitura de chegada à bacia

**Data:** 2026-08-26
**Região:** R6 — Ruínas Submersas
**Tarefa concluída:** `DEV6-R6-BASIN-ARRIVAL-READING-004`

## Entrega

A camada `levels/regions/r6/R6BasinArrivalReading.gd` reforça a leitura de chegada usando exclusivamente os dois vestígios físicos já presentes no limiar da bacia. O vestígio ocidental abre a vista e o oriental conduz o olhar para a água. Não foram criados elementos físicos, luzes, colisores, efeitos, shaders ou conteúdo da R7.

| Verificação | Resultado |
|---|---|
| Pilares reutilizados | 2 |
| Nós e geometria adicionais | 0 |
| Luzes e colisores adicionais | 0 |
| Orçamento R6 | 4 luzes aprovado |
| Provas R6 | Linha de água, chegada à bacia e handoff R6→R7 aprovados |
| Rotas | `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival` aprovadas |
| Gate R6 | Aprovado |

## Sucessão

A próxima tarefa é `DEV6-R6-BASIN-VISTA-READING-005`: auditar e ajustar apenas a leitura estática da silhueta da bacia usando materiais e elementos R6 existentes. Não pode criar nós, geometria, luz, colisão, água falsa, partículas, shader, painel, interface ou antecipação da R7. A entrega deve preservar a abertura de chegada e todas as rotas R6.
