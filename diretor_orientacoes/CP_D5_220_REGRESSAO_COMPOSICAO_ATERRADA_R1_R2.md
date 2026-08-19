# CP-D5-220 — Regressão da composição multi-landmark aterrada R1→R2

## Resultado

A cena `MultiLandmarkGroundedPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os dois landmarks foram ajustados ao terreno irregular por raycast, preservando as coordenadas cartográficas X/Z e sem alterar a produção.

| Candidato | Âncora | Canvas/mapa | World X/Z | Y desejado | Y impacto | Aterrado |
|---|---:|---|---|---:|---:|---|
| Casa Voss | 1 | `(80,452)` | `(−22,8)` | 15,00 | −2,52 | `true` |
| Ponte Marco 2 | 2 | `(234,462)` | `(−21,4;12)` | 18,00 | −2,52 | `true` |

| Verificação | Resultado |
|---|---|
| Âncoras cobertas | 1 e 2 |
| Terreno irregular | `true` |
| Script de produção | `false` |
| Luzes dinâmicas | 0 |
| X/Z preservados | `true` |
| Estado | `approved` |

A regressão aprova a composição multi-landmark R1→R2 e preserva o corredor central, sem introduzir o Arco estrutural rejeitado. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. O log está em `CP-D5-220_MULTI_LANDMARK_RUNTIME.log`.
