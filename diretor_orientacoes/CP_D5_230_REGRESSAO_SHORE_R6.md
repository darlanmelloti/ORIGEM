# CP-D5-230 — Regressão da costa viva R6

## Resultado

A cena `R6LivingShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias chega à costa R6 com leitura de ruínas colapsadas, terreno aterrado e transição aberta para o marcador R7, sem repetir o cais rejeitado.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Fauna | 2 elementos |
| Vegetação | 4 elementos |
| Partes de ruína | 3 |
| Elementos aterrados | 9 |
| Lajes de cais | 0 |
| Ruína colapsada | `true` |
| Parede de árvores | `false` |
| Módulos de produção alterados | `false` |
| Ciclos de rota | 1, `clear=true` |
| Distância de fauna | 20,08 |

A regressão aprova a leitura orgânica de shoreline R6 e confirma a exclusão do padrão de cais com lajes. O log está em `CP-D5-230_R6_SHORE_RUNTIME.log`.
