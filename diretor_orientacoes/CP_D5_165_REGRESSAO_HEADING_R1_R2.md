# CP-D5-165 — Regressão de heading R1→R2 de Elias

## Resultado

A cena `EliasVossRoadHeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A saída da Casa Voss orientou Elias para a Estrada do Rio sem saltar a âncora R2.

| Verificação | Resultado |
|---|---|
| Casa Voss XZ | `(−22.00,8.00)` |
| Âncora Estrada | `(−21.40,12.00)` |
| Ponte candidata | `(−21.40,28.00)` |
| Posição inicial | `(−18.00,8.00)` |
| Destino | `RUMO À ESTRADA DO RIO` id 2 |
| Ciclos de rota | 8 |
| Câmara Elias de produção | `false` |
| Estado | `approved` |
| Produção | Inalterada |

A regressão confirma a transição R1→R2 e preserva o contrato de integração isolada. O log está em `CP-D5-165_VOSS_ROAD_HEADING_RUNTIME.log`.
