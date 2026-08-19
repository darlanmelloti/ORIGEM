# CP-D5-251 — Regressão leitura vegetal R6 por Elias

## Resultado

A cena `R6EliasVegetationReadPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A leitura vegetal R6 mantém três elementos aterrados ao redor do monólito, clearance amplo para Elias, rota livre e zero lajes de cais.

| Verificação | Resultado |
|---|---|
| Estado | `approved` |
| Monólito aterrado | `true`, `(52.00,260.00)` |
| Vegetação | 3 elementos |
| Árvore leve direita | aterrada em `(73.00,271.00)` |
| Feto esquerdo | aterrado em `(53.50,250.00)` |
| Feto direito | aterrado em `(68.00,267.00)` |
| Rota X | `60.00` |
| Clearance | 6,05 m |
| Lajes de cais | 0 |
| Parede de árvores | `false` |
| Câmara Elias de produção | `false` |
| Módulos de produção alterados | `false` |
| Ciclos de rota | 2, ambos `clear=true` |

A regressão aprova a leitura vegetal R6 por Elias e preserva a abordagem orgânica ao monólito, sem alterar produção. O log está em `CP-D5-251_R6_VEGETATION_READ_RUNTIME.log`.
