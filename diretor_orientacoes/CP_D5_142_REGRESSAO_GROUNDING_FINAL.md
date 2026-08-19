# CP-D5-142 — Regressão final do grounding cartográfico

## Resultado

A cena `CartographicGroundingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Dois candidatos foram alinhados ao terreno por raycast sem deslocar os seus eixos X/Z.

| Candidato | Y desejado | Y impacto | Grounding | Colisor |
|---|---:|---:|---|---|
| `anexo_casa_voss` | 15,00 m | -2,78 m | `true` | `TerrenoColisorQA` |
| `ponte_marco_2` | 18,00 m | -2,71 m | `true` | `TerrenoColisorQA` |

Ambos os candidatos confirmaram `xz_preserved=true`. A regressão final mantém o sistema de grounding isolado da produção. O log está em `CP-D5-142_GROUNDING_RUNTIME.log`.
