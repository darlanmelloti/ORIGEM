# CP-D5-167 — Regressão da margem orgânica R6

## Resultado

A cena `R6OrganicShorePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A margem orgânica substitui a linguagem de cais estrutural e preserva a chegada às Ruínas.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Monólito aterrado | `true` |
| Monólito XZ | `(52.00,260.00)` |
| Monólito Y | `0.09` |
| Terreno orgânico aterrado | 10 elementos |
| Folhagem | 4 elementos |
| Afloramentos | 5 |
| Lajes de cais | 0 |
| Cubos de margem | `false` |
| Parede de árvores | `false` |
| Ciclos de rota limpos | 2 |
| Módulos de produção alterados | `false` |

A regressão aprova a margem orgânica R6 sem repetir o cais rejeitado e sem modificar produção. O log está em `CP-D5-167_R6_ORGANIC_SHORE_RUNTIME.log`.
