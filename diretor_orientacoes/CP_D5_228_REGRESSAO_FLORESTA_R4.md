# CP-D5-228 — Regressão da floresta viva R4

## Resultado

A cena `R4LivingForestPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição mantém leitura natural de floresta para Elias, com rota aberta para R5, sem portal estrutural nem parede de árvores.

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
| Estado | `approved` |

A regressão aprova a floresta R4 para a apresentação técnica de Elias, respeitando a rejeição de portais e a densidade orgânica da composição. O log está em `CP-D5-228_R4_FOREST_RUNTIME.log`.
