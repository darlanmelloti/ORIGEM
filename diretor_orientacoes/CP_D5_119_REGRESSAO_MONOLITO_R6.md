# CP-D5-119 — Regressão do monólito da margem R6

## Resultado

A cena `SubmergedShoreMonolithPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O monólito da âncora 6 foi aterrado na margem R6 sem deslocamento X/Z e sem recuperar a geometria rejeitada do cais.

| Verificação | Resultado |
|---|---|
| Âncora | 6 |
| X/Z | `(52,260)` preservado |
| Y desejado | 18,00 m |
| Y de impacto | -0,00 m |
| Grounding | `true` |
| Colisor | `MargemR6ColisorQA` |
| Luzes dinâmicas adicionadas | 0 |
| Lajes de cais | 0 |
| Colunas uniformes | 0 |
| Produção | Inalterada |

A regressão confirma o landmark de leitura vertical da margem sem linguagem de cais e sem módulos de produção. O log está em `CP-D5-119_R6_MONOLITH_RUNTIME.log`.
