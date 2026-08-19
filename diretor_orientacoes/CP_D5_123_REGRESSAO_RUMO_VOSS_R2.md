# CP-D5-123 — Regressão do rumo Elias R1→R2

## Resultado

A cena `EliasVossRoadHeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O rumo partiu de Casa Voss e manteve oito ciclos apontados à Estrada do Rio.

| Verificação | Resultado |
|---|---|
| Casa Voss | `(-22,8)` |
| Estrada do Rio | `(-21,4;12)` |
| Ponte R2 | `(-21,4;28)` |
| Ciclos de rumo | 8 |
| Destino | `RUMO À ESTRADA DO RIO`, id 2 |
| Câmara de Elias | Inactiva; contrato externo preservado |
| Parser | Aprovado |
| Produção | Inalterada |

A regressão confirma o primeiro handoff navegável de Elias sem salto de âncora ou alteração dos módulos de produção. O log está em `CP-D5-123_VOSS_HEADING_RUNTIME.log`.
