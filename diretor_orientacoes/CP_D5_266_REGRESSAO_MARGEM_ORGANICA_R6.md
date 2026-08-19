# CP-D5-266 — Regressão margem orgânica R6

## Resultado

A cena `R6OrganicShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A margem R6 mantém terreno orgânico, monólito aterrado, vegetação, afloramentos naturais e rota aberta para R7, sem cais ou cubos de shoreline.

| Verificação | Resultado |
|---|---|
| Terreno orgânico | `true` |
| Monólito aterrado | `true`, X/Z `(52,260)`, Y `0,09` |
| Elementos aterrados | 10 |
| Folhagens | 4 |
| Afloramentos | 5 |
| Lajes de cais | 0 |
| Cubos de shoreline | `false` |
| Parede de árvores | `false` |
| Ciclos de rota | 2, ambos `clear=true` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A regressão aprova a margem orgânica R6 e preserva a leitura natural da costa sem estruturas rejeitadas. Os avisos FSR1 são específicos do renderer Compatibility em headless. O log está em `CP-D5-266_ORGANIC_SHORE_RUNTIME.log`.
