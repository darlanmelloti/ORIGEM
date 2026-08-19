# CP-D5-303 — Auditoria final de orçamento LOD e vegetação

A cena `VegetationLodAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). Os activos reais foram medidos e confirmaram os limites definidos para GTX 1050 Ti.

| Activo | Triângulos | Colisões |
|---|---:|---:|
| Pinheiro PBR focal | 13.424 | 0 |
| Árvore detalhada média | 402 | 0 |
| Feto focal isolado | 6.232 | 0 |
| Alternativa leve distante | 114 | 0 |

O contrato de composição permanece: **1 árvore PBR focal**, **3 árvores detalhadas médias**, **8 folhagens leves distantes** e **0 luzes dinâmicas**. Não foram observados erros de parser ou script. Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless. Evidência completa: `CP-D5-303_FINAL_BUDGET_RUNTIME.log`.
