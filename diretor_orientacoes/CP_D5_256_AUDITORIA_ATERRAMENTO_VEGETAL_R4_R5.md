# CP-D5-256 — Auditoria de aterramento vegetal R4–R5

## Resultado

A cena `GroundedVegetationR4R5Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Todos os 12 candidatos vegetais foram aterrados com as coordenadas X/Z preservadas, sem adicionar luzes dinâmicas ou parede de árvores.

| Região | Elementos | Estado |
|---|---:|---|
| R4 | 6 | todos `grounded=true`, `xz_preserved=true` |
| R5 | 6 | todos `grounded=true`, `xz_preserved=true` |
| **Total** | **12** | aprovado |

| Composição | Quantidade |
|---|---:|
| Pinheiro focal | 1 |
| Árvores detalhadas | 3 |
| Folhagem leve | 6 |
| Fetos | 2 |
| Luzes dinâmicas adicionadas | 0 |
| Parede de árvores | `false` |
| Módulos de produção alterados | `false` |

A regressão aprova a continuidade vegetal R4→R5 para Elias e preserva as posições cartográficas, sem modificar produção. O log está em `CP-D5-256_GROUNDED_VEGETATION_RUNTIME.log`.
