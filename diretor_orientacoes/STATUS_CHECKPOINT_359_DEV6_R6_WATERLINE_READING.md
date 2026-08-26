# STATUS CHECKPOINT 359 — Dev6 R6: leitura arqueológica da linha de água

**Data:** 2026-08-26
**Região:** R6 — Ruínas Submersas
**Tarefa concluída:** `DEV6-R6-WATERLINE-READING-003`

## Entrega

A leitura de margem foi transferida para o módulo isolado `levels/regions/r6/R6WaterlineReading.gd`. A implementação cria três conjuntos assimétricos, totalizando nove vestígios rochosos colocados na margem exterior da bacia. Não introduz `Light3D`, colisores, shader, emissão, painel ou geometria no leito e não altera a âncora, a cascata, a estela, as lajes do handoff nem a futura R7.

| Verificação | Resultado |
|---|---|
| Conjuntos arqueológicos | 3 |
| Vestígios | 9 |
| Luzes e colisores do módulo | 0 |
| Orçamento R6 | 4 luzes aprovado |
| Handoff R6→R7 | Lajes e marcos preservados |
| Rotas | `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival` aprovadas |
| Gate R6 | Aprovado |

A prova `qa/regions/verify_r6_waterline_reading.gd` agora é obrigatória na porta R6 e verifica conjuntos, vestígios, limites espaciais, ausência de luz e ausência de colisores.

## Sucessão

A próxima tarefa é `DEV6-R6-BASIN-ARRIVAL-READING-004`: reforçar a leitura estática da chegada à bacia usando apenas elementos R6 existentes, sem luz, água falsa, shader, painel, rota artificial, colisão adicional ou construção da R7. O trabalho deve preservar o limiar real das ruínas e as três rotas R6.
