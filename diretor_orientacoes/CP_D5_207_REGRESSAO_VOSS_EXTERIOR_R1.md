# CP-D5-207 — Regressão do exterior vivo Casa Voss R1

## Resultado

A cena `R1LivingVossExteriorPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O exterior vivo preservou a waystation, a abertura frontal e a rota de saída de Elias sem tocar nas portas ou no interior de produção.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Waystation | `true` |
| Elementos de jardim | 5 |
| Fauna | 2 elementos |
| Elementos aterrados | 8 |
| Ciclos limpos | 4 |
| Distância fauna | 9,07–9,87 m |
| Casa de produção tocada | `false` |
| Portas tocadas | `false` |
| Módulos de produção alterados | `false` |

A regressão aprova o exterior vivo Casa Voss R1, preservando portas e interiores de produção. O log está em `CP-D5-207_R1_VOSS_EXTERIOR_RUNTIME.log`.
