# CP-D5-212 — Regressão do monólito de margem R6

## Resultado

A cena `SubmergedShoreMonolithPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O monólito foi aterrado por raycast na margem orgânica, preservando X/Z e sem reintroduzir linguagem estrutural de cais.

| Verificação | Resultado |
|---|---|
| Âncora | 6 |
| Monólito X/Z | `(52.00,260.00)` |
| Y desejado | 18,00 m |
| Y de impacto | −0,00 m |
| Aterrado | `true` |
| X/Z preservado | `true` |
| Colisor | `MargemR6ColisorQA` |
| Luzes dinâmicas adicionadas | 0 |
| Lajes de cais | 0 |
| Colunas uniformes | 0 |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A regressão aprova o monólito orgânico da margem R6, sem cais estrutural ou iluminação extra. O log está em `CP-D5-212_R6_SHORE_MONOLITH_RUNTIME.log`.
