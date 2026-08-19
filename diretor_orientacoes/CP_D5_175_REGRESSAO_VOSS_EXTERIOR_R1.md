# CP-D5-175 — Regressão do exterior vivo Casa Voss R1

## Resultado

A cena `R1LivingVossExteriorPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O exterior vivo da Casa Voss manteve a saída navegável e não tocou portas ou interiores de produção.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Fauna | 2 elementos |
| Elementos de jardim | 5 |
| Elementos aterrados | 8 |
| Waystation | `true` |
| Distância fauna nos ciclos | 9,07–9,87 m |
| Ciclos limpos | 4 |
| Casa de produção tocada | `false` |
| Portas de produção tocadas | `false` |
| Módulos de produção alterados | `false` |

A regressão aprova o exterior vivo R1 e preserva explicitamente portas e interiores da Casa Voss. Avisos FSR1 do renderer Compatibility não afectaram o parser nem o script Dev5. O log está em `CP-D5-175_R1_VOSS_EXTERIOR_RUNTIME.log`.
