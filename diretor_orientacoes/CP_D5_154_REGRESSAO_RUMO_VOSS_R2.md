# CP-D5-154 — Regressão do rumo Elias R1→R2

## Resultado

A cena `EliasVossRoadHeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias manteve o rumo correcto da Casa Voss para a Estrada do Rio ao longo de oito ciclos.

| Verificação | Resultado |
|---|---|
| Casa Voss X/Z | `(-22,8)` |
| Âncora Estrada do Rio | `(-21,4;12)` |
| Ponte R2 | `(-21,4;28)` |
| Início Elias | `(-18,8)` |
| Destino | `RUMO À ESTRADA DO RIO`, id 2 |
| Ciclos de rumo | 8 |
| Câmara | Externa QA |
| Produção | Inalterada |

A regressão confirma a sequência de navegação R1→R2 sem saltos e preserva a orientação cartográfica canónica. O log está em `CP-D5-154_VOSS_HEADING_RUNTIME.log`.
