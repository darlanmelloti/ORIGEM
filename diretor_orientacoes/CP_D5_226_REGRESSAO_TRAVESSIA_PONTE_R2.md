# CP-D5-226 — Regressão da travessia da ponte R2 por Elias

## Resultado

A cena `EliasStoneBridgeTraversalPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias atravessou o tabuleiro modular R2 em três ciclos, com aterramento, clearance suficiente e sem carregar a ponte GLB rejeitada.

| Verificação | Resultado |
|---|---|
| Âncora R2 | `(−21.40,28.00)` |
| Aterrado | `true` |
| Colisor | `tabuleiro_continuo` |
| Clearance do tabuleiro | 0,21 m |
| Mínimo exigido | 0,20 m |
| Tipo de ponte | `modular_not_glb` |
| Ponte modular | `true` |
| Ponte GLB | `false` |
| Ciclos de travessia | 3 |
| Câmara Elias de produção | `false` |
| Estado | `approved` |

A regressão aprova a travessia modular R2 e preserva o tabuleiro físico da estrada, sem reintroduzir a ponte GLB rejeitada. O log está em `CP-D5-226_R2_BRIDGE_TRAVERSAL_RUNTIME.log`.
