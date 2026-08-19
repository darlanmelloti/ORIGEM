# CP-D5-065 — Validação de vegetação grounded R4/R5

## Resultado

O preview `GroundedVegetationR4R5Preview.tscn` passou uma sessão QA de 36 segundos. Todos os 12 candidatos vegetais foram aterrados com `grounded=true` e `xz_preserved=true`.

| Critério | Resultado |
|---|---:|
| Candidatos | 12 |
| R4 | 6 elementos |
| R5 | 6 elementos |
| Pine focal | 1 |
| Vegetação detalhada | 3 |
| Vegetação leve | 6 |
| Fetos | 2 |
| Luzes dinâmicas adicionadas | 0 |
| Parede de árvores | `false` |
| Módulos de produção alterados | `false` |
| Runtime | 36 segundos |
| `SCRIPT ERROR` | 0 |

A advertência FSR1 é do renderer Compatibility local. A captura visual final de R4/R5 continua pendente de viewport gráfico válido.

O log está em `CP-D5-065_VEGETATION_RUNTIME.log`.
