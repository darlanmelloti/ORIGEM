# CP-D5-112 — Regressão do grounding cartográfico

## Resultado

A cena `CartographicGroundingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O sistema aterrou o anexo Casa Voss e a ponte do marco 2 em terreno irregular, alterando apenas Y e preservando X/Z.

| Candidato | Y desejado | Y de impacto | X/Z | Resultado |
|---|---:|---:|---|---|
| Anexo Casa Voss | 15,00 m | -2,78 m | Preservado | `grounded=true` |
| Ponte marco 2 | 18,00 m | -2,71 m | Preservado | `grounded=true` |

A regressão confirma o contrato de aterramento sem módulos de produção, sem dependências de `Player.gd` e sem alteração horizontal dos candidatos. O log completo está em `CP-D5-112_GROUNDING_RUNTIME.log`.
