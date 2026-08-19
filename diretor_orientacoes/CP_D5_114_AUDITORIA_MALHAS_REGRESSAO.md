# CP-D5-114 — Regressão do orçamento de malhas Dev5

## Resultado

A cena `MeshBudgetAuditPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A auditoria recontou os activos usados pelos candidatos Dev5 para o alvo GTX 1050 Ti.

| Activo | Triângulos |
|---|---:|
| Ponte de pedra | 252 |
| Pedra grande | 80 |
| Árvore detalhada | 402 |
| Pinheiro PBR | 13.424 |
| Feto | 6.232 |
| **Total auditado** | **20.390** |

A sessão confirmou 9 nós de malha, 12 slots de material, zero colisores importados e zero luzes dinâmicas no lote auditado. A auditoria mantém o limite de uma árvore PBR focal e não autoriza integrar automaticamente activos na produção. O log está em `CP-D5-114_MESH_BUDGET_RUNTIME.log`.
