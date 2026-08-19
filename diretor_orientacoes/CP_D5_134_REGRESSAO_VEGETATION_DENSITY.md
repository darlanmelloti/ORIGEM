# CP-D5-134 — Regressão de densidade vegetal GTX 1050 Ti

## Resultado

A cena `VegetationDensityAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição manteve densidade limitada por planos, sem formar parede vegetal.

| Verificação | Resultado |
|---|---:|
| Pinheiro focal | 1 |
| Árvores médias escuras | 3 |
| Árvore leve | 1 |
| Fetos em primeiro plano | 2 |
| Triângulos totais | 27.208 |
| Luzes dinâmicas | 0 |
| Parede vegetal | `false` |
| Parser | Aprovado |
| Produção | Inalterada |

A regressão confirma a composição vegetal compatível com o alvo GTX 1050 Ti e preserva a legibilidade do corredor. O log está em `CP-D5-134_VEGETATION_DENSITY_RUNTIME.log`.
