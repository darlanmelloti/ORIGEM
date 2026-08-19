# CP-D5-195 — Regressão da travessia da ponte R2 por Elias

## Resultado

A cena `EliasStoneBridgeTraversalPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias atravessou a ponte modular três vezes com tabuleiro contínuo e clearance acima do contrato mínimo.

| Verificação | Resultado |
|---|---|
| Âncora R2 | `(−21.40,28.00)` |
| Ponte aterrada | `true` |
| Colisor | `tabuleiro_continuo` |
| Clearance do tabuleiro | 0,21 m |
| Mínimo requerido | 0,20 m |
| Tipo | `modular_not_glb` |
| Ciclos limpos | 3 |
| Ponte modular | `true` |
| Ponte GLB | `false` |
| Câmara Elias de produção | `false` |
| Estado | `approved` |

A regressão aprova a travessia modular R2 sem reintroduzir o GLB rejeitado e sem alterar produção. O log está em `CP-D5-195_R2_BRIDGE_TRAVERSAL_RUNTIME.log`.
