# CP-D5-236 — Auditoria de densidade vegetal

## Resultado

A cena `VegetationDensityAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A composição aprovada mantém uma árvore focal, três árvores médias, uma árvore leve e dois fetos de primeiro plano, sem saturar a leitura cartográfica.

| Elemento | Quantidade |
|---|---:|
| Pinheiro focal | 1 |
| Árvore detalhada média | 3 |
| Árvore leve distante | 1 |
| Feto de primeiro plano | 2 |
| Triângulos totais | 27.208 |
| Luzes dinâmicas | 0 |
| Densidade parede de árvores | `false` |
| Estado | `approved` |

A auditoria confirma o orçamento vegetal e a compatibilidade com GTX 1050 Ti, preservando a composição orgânica e o limite de iluminação Dev5. O log está em `CP-D5-236_VEGETATION_DENSITY_RUNTIME.log`.
