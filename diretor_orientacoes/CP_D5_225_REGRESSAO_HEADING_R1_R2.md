# CP-D5-225 — Regressão do heading e saída R1→R2

## Resultado

A cena `EliasVossRoadHeadingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Elias saiu da Casa Voss em direcção à Estrada do Rio, mantendo a rota aberta em oito ciclos.

| Verificação | Resultado |
|---|---|
| Casa Voss X/Z | `(−22.00,8.00)` |
| Âncora Estrada | `(−21.40,12.00)` |
| Ponte Marco | `(−21.40,28.00)` |
| Início Elias | `(−18.00,8.00)` |
| Destino | `RUMO À ESTRADA DO RIO` |
| ID do destino | 2 |
| Ciclos de rota | 8 |
| Câmara Elias de produção | `false` |
| Estado | `approved` |

A regressão aprova o heading R1→R2, preservando as âncoras cartográficas e a apresentação third-person externa. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. O log está em `CP-D5-225_R1_R2_HEADING_RUNTIME.log`.
