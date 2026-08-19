# CP-D5-295 — Regressão do aterramento cartográfico

`CartographicGroundingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). O raycast em terreno irregular aterrou dois candidatos, preservando X/Z e resolvendo somente Y.

| Candidato | Y desejado | Y de impacto | X/Z | Estado |
|---|---:|---:|---|---|
| Anexo Casa Voss | 15,00 | -2,78 | preservado | `grounded=true` |
| Ponte Marco 2 | 18,00 | -2,71 | preservado | `grounded=true` |

O colisor utilizado foi `TerrenoColisorQA`. Não houve erro de script ou parser, nem alteração em módulos de produção ou `Player.gd`. Evidência completa: `CP-D5-295_GROUNDING_RUNTIME.log`.
