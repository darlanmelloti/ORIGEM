# CP-D5-267 — Regressão monólito submerso R6

## Resultado

A cena `SubmergedShoreMonolithPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O monólito R6 permaneceu aterrado através do collider da margem, com coordenadas X/Z preservadas, sem cais, colunas uniformes ou luzes dinâmicas adicionadas.

| Verificação | Resultado |
|---|---|
| Âncora | 6 |
| Monólito X/Z | `(52.00,260.00)` |
| Y desejado | 18,00 |
| Y de impacto | −0,00 |
| Aterrado | `true` |
| X/Z preservado | `true` |
| Collider | `MargemR6ColisorQA` |
| Lajes de cais | 0 |
| Colunas uniformes | 0 |
| Luzes dinâmicas adicionadas | 0 |
| Módulos de produção alterados | `false` |
| Estado | `approved` |

A regressão aprova a leitura do monólito submerso e preserva a margem orgânica R6 sem reintroduzir a linguagem visual rejeitada. Os avisos FSR1 são específicos do renderer Compatibility em headless. O log está em `CP-D5-267_SUBMERGED_RUINS_RUNTIME.log`.
