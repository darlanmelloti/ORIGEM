# CP-D5-249 — Regressão Majestic R5 vivo

## Resultado

A cena `R5LivingMajesticPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição Majestic mantém pavilhão visível, fauna, vegetação, abrigo e aterramento completos, com rota aberta para R6 e sem cairn ou parede de árvores.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Fauna | 2 elementos |
| Vegetação | 8 elementos |
| Partes de abrigo | 3 |
| Pavilhão | `true`, visível na rota |
| Elementos aterrados | 14 |
| Cairn | `false` |
| Parede de árvores | `false` |
| Módulos de produção alterados | `false` |
| Ciclos de rota | 1, `clear=true` |
| Distância de fauna | 27,41 |

A regressão aprova o Majestic R5 vivo para QA e preserva a passagem cartográfica para R6 sem introduzir elementos estruturais rejeitados. O log está em `CP-D5-249_R5_LIVING_MAJESTIC_RUNTIME.log`.
