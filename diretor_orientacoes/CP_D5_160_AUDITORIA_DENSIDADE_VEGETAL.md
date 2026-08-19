# CP-D5-160 — Auditoria de densidade vegetal e orçamento GTX 1050 Ti

## Resultado

A cena `VegetationDensityAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição mantém densidade moderada e não cria uma parede de árvores.

| Métrica | Resultado |
|---|---|
| Composição focal | 1 pinheiro PBR |
| Vegetação média | 3 árvores detalhadas |
| Vegetação distante | 1 árvore leve |
| Primeiro plano | 2 fetos |
| Triângulos totais | 27.208 |
| Luzes dinâmicas | 0 |
| Parede de árvores | `false` |
| Compatibilidade alvo | GTX 1050 Ti / OpenGL Compatibility |
| Estado | `approved` |

A auditoria confirma o orçamento Dev5 para a composição vegetal sem alterar módulos de produção. O log está em `CP-D5-160_VEGETATION_DENSITY_RUNTIME.log`.
