# CP-D5-263 — Regressão multi-marco de aterramento

## Resultado

A cena `MultiLandmarkGroundedPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os marcos Casa Voss e Ponte Marco 2 permaneceram aterrados sobre o terreno irregular, com coordenadas cartográficas X/Z preservadas, sem scripts de produção ou luzes dinâmicas.

| Marco | Âncora | Coordenada cartográfica | Y desejado | Y de impacto | Aterrado |
|---|---:|---|---:|---:|---|
| Casa Voss | 1 | `(80,452)` / `(-22,8)` | 15,00 | −2,52 | `true` |
| Ponte Marco 2 | 2 | `(234,462)` / `(-21,4;12)` | 18,00 | −2,52 | `true` |

| Contrato | Resultado |
|---|---|
| Anchors avaliados | 1, 2 |
| Terreno irregular | `true`, aterramento aprovado |
| Scripts de produção | 0 |
| Luzes dinâmicas | 0 |
| Estado | `approved` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-263_MULTILANDMARK_GROUNDING_RUNTIME.log`.
