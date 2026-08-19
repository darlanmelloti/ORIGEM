# CP-D5-152 — Auditoria final de iluminação e grounding R4/R5

## Resultado

A cena alternativa autorizada `GroundedVegetationR4R5Preview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Foram validados 12 candidatos de vegetação em R4/R5, todos aterrados com X/Z preservado.

| Verificação | Resultado |
|---|---:|
| Candidatos | 12 |
| Pinheiro focal | 1 |
| Árvores detalhadas | 3 |
| Elementos leves distantes | 6 |
| Fetos | 2 |
| Candidatos aterrados | 12/12 |
| X/Z preservado | Confirmado |
| Luzes dinâmicas adicionadas | 0 |
| Parede vegetal | `false` |
| Produção | Inalterada |

A auditoria confirma o limite técnico de iluminação sem criar uma cena de luz inexistente e mantém o fallback autorizado dentro de `levels/dev5/`. O log está em `CP-D5-152_LIGHT_BUDGET_RUNTIME.log`.
