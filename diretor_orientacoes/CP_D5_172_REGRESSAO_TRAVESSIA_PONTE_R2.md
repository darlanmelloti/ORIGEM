# CP-D5-172 — Regressão da travessia da ponte R2

## Resultado

A cena `EliasStoneBridgeTraversalPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A ponte modular manteve o tabuleiro contínuo e aterrado, sem reintroduzir o candidato GLB rejeitado.

| Verificação | Resultado |
|---|---|
| Âncora | R2 |
| Ponte XZ | `(−21.40,28.00)` |
| Aterrada | `true` |
| Colisor | `tabuleiro_continuo` |
| Clearance do tabuleiro | 0,21 m |
| Mínimo requerido | 0,20 m |
| Tipo | `modular_not_glb` |
| Ponte GLB | `false` |
| Ciclos limpos | 3 |
| Câmara Elias de produção | `false` |
| Estado | `approved` |

A regressão aprova a travessia da ponte modular como candidata QA, mantendo o GLB rejeitado fora da sequência e a produção inalterada. O log está em `CP-D5-172_BRIDGE_TRAVERSAL_RUNTIME.log`.
