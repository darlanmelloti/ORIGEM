# CP-D5-179 — Regressão do aterramento cartográfico

## Resultado

A cena `CartographicGroundingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Dois candidatos foram aterrados por raycast no terreno QA, ajustando apenas Y e preservando X/Z.

| Candidato | Y desejado | Y de impacto | X/Z preservado | Estado |
|---|---:|---:|---|---|
| Anexo Casa Voss | 15,00 m | −2,78 m | `true` | Aterrado |
| Ponte marco 2 | 18,00 m | −2,71 m | `true` | Aterrado |

| Verificação | Resultado |
|---|---|
| Contactos válidos | 2/2 |
| Colisor | `TerrenoColisorQA` |
| Método | Raycast vertical |
| Produção alterada | `false` |
| Estado | `approved` |

A regressão confirma a fundação de aterramento para os previews Dev5 sem tocar módulos de produção. O log está em `CP-D5-179_GROUNDING_RUNTIME.log`.
