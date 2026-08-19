# CP-D5-229 — Regressão da composição viva Majestic R5

## Resultado

A cena `R5LivingMajesticPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição Majestic permanece legível para Elias, com pavilhão visível, rota aberta para R6 e sem cairn ou parede de árvores.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Fauna | 2 elementos |
| Vegetação | 8 elementos |
| Partes de abrigo | 3 |
| Pavilhão | `true` |
| Elementos aterrados | 14 |
| Cairn estrutural | `false` |
| Parede de árvores | `false` |
| Módulos de produção alterados | `false` |
| Ciclos de rota | 1, `clear=true` |
| Distância de fauna | 27,41 |
| Pavilhão visível | `true` |

A regressão aprova a composição R5 e preserva a transição para as Ruínas R6, sem adicionar geometrias estruturais rejeitadas. O log está em `CP-D5-229_R5_MAJESTIC_RUNTIME.log`.
