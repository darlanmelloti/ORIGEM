# CP-D5-248 — Regressão floresta R4 viva

## Resultado

A cena `R4LivingForestPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A floresta R4 mantém composição viva, abrigo e rota aberta, sem portal estrutural, sem parede de árvores e sem alterações aos módulos de produção.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Fauna | 2 elementos |
| Vegetação | 8 elementos |
| Partes de abrigo | 2 |
| Elementos aterrados | 12 |
| Portal estrutural | `false` |
| Parede de árvores | `false` |
| Módulos de produção alterados | `false` |
| Ciclos de rota | 3, todos `clear=true` |
| Distância de fauna | 20,42–20,77 |

A regressão aprova a composição viva R4 para QA e preserva a linguagem natural do bosque sem reintroduzir estruturas rejeitadas. O log está em `CP-D5-248_R4_LIVING_FOREST_RUNTIME.log`.
