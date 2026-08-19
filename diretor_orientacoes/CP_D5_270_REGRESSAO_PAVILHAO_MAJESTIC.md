# CP-D5-270 — Regressão pavilhão Majestic R5

## Resultado

A cena `MajesticGroundedPavilionPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O pavilhão Majestic permanece aterrado através da fundação e do `TerrenoMajesticColisorQA`, com coordenadas X/Z preservadas, sem luzes dinâmicas no objecto e sem alterações à produção.

| Verificação | Resultado |
|---|---|
| Âncora | 5 |
| Pavilhão X/Z | `(-88.00,178.00)` |
| Y desejado | 17,00 |
| Y de impacto | −0,00 |
| Objecto aterrado | `true` |
| Fundação aterrada | `true` |
| X/Z preservado | `true` |
| Collider | `TerrenoMajesticColisorQA` |
| Luzes dinâmicas no objecto | 0 |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

Os avisos FSR1 e `viewport_set_scaling_3d_mode` são específicos do renderer Compatibility em headless. O log está em `CP-D5-270_MAJESTIC_PAVILION_RUNTIME.log`.
