# CP-D5-153 — Regressão da travessia de Elias na Ponte de Pedra R2

## Resultado

A cena `EliasStoneBridgeTraversalPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias atravessou a ponte modular com grounding confirmado e corredor livre.

| Verificação | Resultado |
|---|---|
| Âncora | R2 |
| Ponte X/Z | `(-21,40;28,00)` |
| Grounding | `true` |
| Colisor | `tabuleiro_continuo` |
| Folga do tabuleiro | 0,21 m |
| Mínimo exigido | 0,20 m |
| Tipo | Modular, não GLB |
| Ciclos | 3 |
| Câmara de Elias | Externa QA |
| Produção | Inalterada |

A regressão confirma a travessia segura R1→R2 sem reintroduzir a ponte GLB rejeitada. O log está em `CP-D5-153_STONE_BRIDGE_RUNTIME.log`.
