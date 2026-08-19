# CP-D5-242 — Regressão de clearance florestal R4 por Elias

## Resultado

A cena `EliasForestClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição florestal mantém o corredor de Elias aberto, com todos os elementos aterrados e sem portal estrutural ou parede de árvores.

| Elemento | X/Z | Aterrado | Clearance lateral |
|---|---|---|---:|
| Pinheiro focal | `(−16,20;125,00)` | `true` | 6,65 m |
| Árvore média A | `(−2,20;126,40)` | `true` | 6,25 m |
| Árvore média B | `(−19,00;133,00)` | `true` | 9,45 m |
| Árvore leve A | `(2,50;134,50)` | `true` | 10,95 m |
| Árvore leve B | `(−23,00;136,00)` | `true` | 13,45 m |
| Feto esquerdo | `(−12,30;120,60)` | `true` | 2,75 m |

| Verificação | Resultado |
|---|---|
| Âncora R4 | `(−9,116)` |
| Largura do corredor | 5,20 m |
| Clearance mínimo | 2,75 m |
| Ciclos de rota | 2, ambos abertos |
| Portal florestal | `false` |
| Parede de árvores | `false` |
| Câmara Elias de produção | `false` |
| Estado | `approved` |

A regressão aprova a passagem de Elias pela composição R4 sem reintroduzir a linguagem rejeitada de portal ou parede vegetal. O log está em `CP-D5-242_R4_FOREST_CLEARANCE_RUNTIME.log`.
