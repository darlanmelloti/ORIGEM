# CP-D5-163 — Regressão de clearance de Elias na Floresta R4

## Resultado

A cena `EliasForestClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Toda a vegetação QA foi aterrada, o corredor permaneceu aberto e não houve repetição do portal estrutural rejeitado.

| Verificação | Resultado |
|---|---|
| Âncora | R4 `(−9.00,116.00)` |
| Largura do corredor | 5,20 m |
| Clearance mínimo | 2,75 m |
| Ciclos de rota limpos | 2 |
| Elementos aterrados | 6/6 |
| `corridor_open` | `true` |
| Portal estrutural | `false` |
| Parede de árvores | `false` |
| Câmara Elias de produção | `false` |
| Estado | `approved` |

A regressão confirma a passagem third-person na Floresta Densa com margem de fauna preservada e produção inalterada. O log está em `CP-D5-163_FOREST_CLEARANCE_RUNTIME.log`.
