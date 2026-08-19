# CP-D5-115 — Regressão de LOD vegetal

## Resultado

A cena `VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os quatro activos vegetais foram recontados para o alvo GTX 1050 Ti.

| Activo | Triângulos | Colisores |
|---|---:|---:|
| Pinheiro PBR focal | 13.424 | 0 |
| Árvore detalhada média | 402 | 0 |
| Feto | 6.232 | 0 |
| Folhagem leve distante | 114 | 0 |

Os limites permanecem: 1 árvore PBR focal, até 3 árvores detalhadas médias e até 8 elementos leves distantes. A auditoria confirmou zero luzes dinâmicas, sem colisores importados e sem módulos de produção alterados. O log está em `CP-D5-115_VEGETATION_LOD_RUNTIME.log`.
