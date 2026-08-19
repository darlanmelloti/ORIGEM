# CP-D5-182 — Regressão do monólito de margem R6

## Resultado

A cena `SubmergedShoreMonolithPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O monólito foi aterrado por raycast, preservou X/Z e não recuperou a linguagem de cais estrutural rejeitada.

| Verificação | Resultado |
|---|---|
| Âncora | 6 |
| Monólito XZ | `(52.00,260.00)` |
| Y desejado | 18,00 m |
| Y de impacto | −0,00 m |
| Aterrado | `true` |
| X/Z preservado | `true` |
| Colisor | `MargemR6ColisorQA` |
| Lajes de cais | 0 |
| Colunas uniformes | 0 |
| Luzes dinâmicas adicionadas | 0 |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A regressão aprova o monólito como landmark QA orgânico, sem repetir o cais rejeitado e sem alterar produção. O log está em `CP-D5-182_R6_SHORE_MONOLITH_RUNTIME.log`.
