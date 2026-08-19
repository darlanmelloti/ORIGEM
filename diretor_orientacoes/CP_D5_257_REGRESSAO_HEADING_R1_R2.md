# CP-D5-257 — Regressão heading R1→R2

## Resultado

A cena `EliasVossRoadHeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias inicia junto à Casa Voss e mantém o heading para a River Road, com os anchors da estrada e da ponte no eixo cartográfico correcto.

| Verificação | Resultado |
|---|---|
| Casa Voss X/Z | `(−22.00,8.00)` |
| Anchor River Road | `(−21.40,12.00)` |
| Ponte | `(−21.40,28.00)` |
| Início de Elias | `(−18.00,8.00)` |
| Destino | `RUMO À ESTRADA DO RIO` id 2 |
| Ciclos de rota | 8 |
| Câmara Elias de produção | `false` |
| Parser | `PARSER_EXIT=0` |
| Estado | `approved` |

A regressão aprova o heading R1→R2 e a continuidade para a ponte modular, sem tocar módulos de produção. Os avisos FSR1 são específicos do renderer Compatibility. O log está em `CP-D5-257_R1_R2_HEADING_RUNTIME.log`.
