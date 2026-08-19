# CP-D5-208 — Regressão final de clearance do monólito R6

## Resultado

A cena `R6MonolithClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). A execução de diagnóstico explícita confirmou o monólito aterrado e o corredor navegável junto à baliza.

| Verificação | Resultado |
|---|---|
| Monólito aterrado | `true` |
| Monólito X/Z | `(52.00,260.00)` |
| Colisor | `CorredorMargemR6QA` |
| Rota X | `60.00` |
| Raio do monólito | 1,40 m |
| Raio do jogador | 0,55 m |
| Clearance calculada | 6,05 m |
| Mínimo exigido | 4,00 m |
| Câmara Elias de produção | `false` |
| Estado | `approved` |

A regressão aprova a clearance final R6, preserva X/Z cartográficos e não reintroduz cais ou colunas estruturais. Os avisos FSR1 são incompatibilidade conhecida do Compatibility renderer. O log está em `CP-D5-208_R6_MONOLITH_CLEARANCE_RUNTIME.log`.
