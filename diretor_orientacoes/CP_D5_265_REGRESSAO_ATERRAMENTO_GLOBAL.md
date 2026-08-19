# CP-D5-265 — Regressão global de aterramento cartográfico

## Resultado

A cena `CartographicGroundingPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). Os dois contratos principais de aterramento foram aprovados através do `TerrenoColisorQA`, mantendo as coordenadas X/Z e corrigindo a altura para o impacto real do terreno.

| Elemento | Y desejado | Y de impacto | Aterrado | X/Z preservado | Collider |
|---|---:|---:|---|---|---|
| Anexo Casa Voss | 15,00 | −2,78 | `true` | `true` | `TerrenoColisorQA` |
| Ponte Marco 2 | 18,00 | −2,71 | `true` | `true` | `TerrenoColisorQA` |

| Contrato | Resultado |
|---|---|
| Elementos verificados | 2 |
| Falhas de aterramento | 0 |
| Coordenadas X/Z preservadas | `true` |
| Estado | `approved` |
| Produção alterada | `false` |

Os avisos FSR1 são específicos do renderer OpenGL Compatibility em headless. O log está em `CP-D5-265_GLOBAL_GROUNDING_RUNTIME.log`.
