# CP-D5-156 — Regressão final de folga do monólito R6

## Resultado

A cena `R6MonolithClearancePreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA de 36 segundos (`QA_EXIT=124`, timeout controlado). O monólito permaneceu aterrado e não bloqueou o corredor de Elias.

| Verificação | Resultado |
|---|---|
| Monólito X/Z | `(52,260)` |
| Grounding | `true` |
| Colisor | `CorredorMargemR6QA` |
| Rota Elias X | `60` |
| Raio monólito | 1,40 m |
| Raio jogador | 0,55 m |
| Clearance | 6,05 m |
| Mínimo exigido | 4,00 m |
| Ciclos | 2, ambos `clear=true` |
| Cais | Não introduzido |
| Produção | Inalterada |

A regressão confirma a folga de navegação e preserva a leitura do monólito sem modificar a composição de produção. O log está em `CP-D5-156_MONOLITH_CLEARANCE_RUNTIME.log`.
