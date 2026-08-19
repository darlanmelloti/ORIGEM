# CP-D5-180 — Regressão da composição multi-marco aterrada R1→R2

## Resultado

A cena `MultiLandmarkGroundedPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O anexo Casa Voss e a ponte do marco 2 foram aterrados em terreno irregular, preservando as coordenadas X/Z e a ligação central.

| Candidato | Âncora | Canvas | Y desejado | Y impacto | X/Z preservado |
|---|---:|---|---:|---:|---|
| Casa Voss | 1 | `(80,452)` | 15,00 m | −2,52 m | `true` |
| Ponte marco 2 | 2 | `(234,462)` | 18,00 m | −2,52 m | `true` |

| Verificação | Resultado |
|---|---|
| Terreno irregular | `true` |
| Script de produção | `false` |
| Luzes dinâmicas | 0 |
| Arco R3 rejeitado | Ausente |
| Estado | `approved` |

A regressão aprova a composição multi-marco QA sem modificar produção. Avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. O log está em `CP-D5-180_MULTI_GROUNDED_RUNTIME.log`.
