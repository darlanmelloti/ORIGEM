# CP-D5-122 — Regressão da travessia Elias na Ponte R2

## Resultado

A cena `EliasStoneBridgeTraversalPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A travessia confirmou a âncora R2, o tabuleiro contínuo e uma ponte modular sem reutilizar o GLB rejeitado.

| Verificação | Resultado |
|---|---|
| Âncora | R2 `(-21,40;28)` |
| Grounding | `true` no `tabuleiro_continuo` |
| Folga do tabuleiro | 0,21 m; mínimo 0,20 m |
| Tipo de ponte | Modular |
| Ponte GLB | Ausente (`glb_bridge=false`) |
| Ciclos | 3, todos aprovados |
| Câmara de Elias | Inactiva; contrato externo preservado |
| Produção | Inalterada |

A regressão confirma uma travessia segura e compatível com o orçamento Dev5. O log está em `CP-D5-122_R2_BRIDGE_RUNTIME.log`.
