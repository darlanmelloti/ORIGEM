# CP-D5-217 — Regressão da continuidade vegetal aterrada R4→R5

## Resultado

A cena `GroundedVegetationR4R5Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os 12 candidatos foram aterrados por raycast, mantendo X/Z e a distribuição LOD prevista entre R4 e R5.

| Composição | Quantidade |
|---|---:|
| Pinho focal | 1 |
| Árvores detalhadas/médias | 3 |
| Folhagem leve distante | 6 |
| Fetos | 2 |
| Total | 12 |

| Verificação | Resultado |
|---|---|
| Candidatos aterrados | 12/12 |
| X/Z preservados | `true` em todos |
| Luzes dinâmicas adicionais | 0 |
| Parede de árvores | `false` |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A regressão aprova a continuidade vegetal aterrada R4→R5, com offsets de Y ajustados ao terreno irregular e corredor preservado. O log está em `CP-D5-217_GROUNDED_VEGETATION_RUNTIME.log`.
