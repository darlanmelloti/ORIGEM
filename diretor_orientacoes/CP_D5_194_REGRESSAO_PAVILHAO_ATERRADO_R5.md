# CP-D5-194 — Regressão do pavilhão Majestic aterrado R5

## Resultado

A cena `MajesticGroundedPavilionPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O pavilhão foi resolvido por raycast no terreno lateral Majestic, preservando X/Z e a fundação técnica.

| Verificação | Resultado |
|---|---|
| Âncora | 5 |
| Pavilhão XZ | `(−88.000,178.000)` |
| Y desejado | 17,00 m |
| Y de impacto | −0,00 m |
| Aterrado | `true` |
| X/Z preservado | `true` |
| Fundação aterrada | `true` |
| Colisor | `TerrenoMajesticColisorQA` |
| Luzes dinâmicas do objecto | 0 |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A regressão aprova o aterramento técnico do pavilhão R5 sem activar a câmara de produção ou alterar módulos de produção. O log está em `CP-D5-194_MAJESTIC_GROUNDED_RUNTIME.log`.
