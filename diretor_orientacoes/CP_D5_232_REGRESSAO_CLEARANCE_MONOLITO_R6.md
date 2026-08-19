# CP-D5-232 — Regressão de clearance do monólito R6

## Resultado

A cena `R6MonolithClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O monólito está aterrado no corredor marginal R6 e deixa passagem segura para Elias, com margem superior ao mínimo contratado.

| Verificação | Resultado |
|---|---|
| Monólito aterrado | `true` |
| Monólito X/Z | `(52.00,260.00)` |
| Colisor | `CorredorMargemR6QA` |
| Raio do monólito | 1,40 m |
| Raio de Elias | 0,55 m |
| Clearance mínimo medido | 6,05 m |
| Clearance exigido | 4,00 m |
| Ciclos de rota | 2, ambos `clear=true` |
| Estado | `approved` |

A regressão aprova a colocação do monólito R6 sem bloquear a rota de Elias e preserva o handoff para R7. O log está em `CP-D5-232_R6_MONOLITH_CLEARANCE_RUNTIME.log`.
