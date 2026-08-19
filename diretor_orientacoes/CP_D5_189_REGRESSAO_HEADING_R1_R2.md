# CP-D5-189 — Regressão do heading Casa Voss→Estrada do Rio

## Resultado

A cena `EliasVossRoadHeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias manteve o heading de saída da Casa Voss para a Estrada do Rio em oito ciclos consistentes.

| Verificação | Resultado |
|---|---|
| Casa Voss XZ | `(−22.00,8.00)` |
| Âncora Estrada do Rio | `(−21.40,12.00)` |
| Ponte R2 XZ | `(−21.40,28.00)` |
| Destino | `RUMO À ESTRADA DO RIO` id 2 |
| Ciclos de rota | 8 |
| Câmara Elias de produção | `false` |
| Estado | `approved` |

A regressão confirma a saída cartográfica R1→R2 sem saltos e sem tocar módulos de produção. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. O log está em `CP-D5-189_R1R2_HEADING_RUNTIME.log`.
