# CP-D5-247 — Regressão corredor do Arco R3 vivo

## Resultado

A cena `R3LivingArchCorridorPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O corredor R3 mantém uma leitura viva de fauna, vegetação e ruínas, sem reintroduzir arco estrutural comprimido ou tocar módulos de produção.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Fauna | 2 elementos |
| Vegetação | 4 elementos |
| Partes de ruína | 2 |
| Elementos aterrados | 8 |
| Arco estrutural | `false` |
| Escala comprimida | `false` |
| Módulos de produção alterados | `false` |
| Ciclos de rota | 4, todos `clear=true` |
| Distância de fauna | 11,49–12,26 |

A regressão aprova o corredor vivo R3 para QA e preserva a linguagem cartográfica sem arco estrutural dominante. O log está em `CP-D5-247_R3_ARCH_CORRIDOR_RUNTIME.log`.
