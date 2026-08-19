# CP-D5-227 — Regressão do corredor R3 de Elias

## Resultado

A cena `EliasArchCorridorPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias percorreu o corredor R3 com rota aberta e destino R4, sem reintroduzir o arco estrutural rejeitado.

| Verificação | Resultado |
|---|---|
| R3 X/Z | `(−16.741,48.00)` |
| Referência física do arco | `z=92.00` |
| Destino | `RUMO À FLORESTA` id 4 |
| Câmara Elias de produção | `false` |
| Arco estrutural | `false` |
| Ciclos | 2 |
| Rota aberta | `true` em ambos |
| Estado | `approved` |

A regressão aprova o corredor R3 de Elias e mantém a transição para R4 orgânica, preservando a produção. O log está em `CP-D5-227_R3_ARCH_CORRIDOR_RUNTIME.log`.
