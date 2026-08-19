# CP-D5-181 — Regressão do corredor R3 de Elias

## Resultado

A cena `EliasArchCorridorPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O corredor R3 manteve a rota aberta até à Floresta Densa, sem reintroduzir o arco estrutural rejeitado.

| Verificação | Resultado |
|---|---|
| R3 XZ | `(−16.741,48.00)` |
| Arco físico de referência | `z=92.00` |
| Destino seguinte | `RUMO À FLORESTA` id 4 |
| Rota aberta | `true` em 2 ciclos |
| Arco estrutural | `false` |
| Câmara Elias de produção | `false` |
| Estado | `approved` |
| Produção | Inalterada |

A regressão confirma a transição R3→R4 com corredor técnico aberto e sem repetir a geometria estrutural rejeitada. O log está em `CP-D5-181_R3_ELIAS_CORRIDOR_RUNTIME.log`.
