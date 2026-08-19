# CP-D5-042 — Validação de folga da baliza R6

## Resultado

O corredor central junto à baliza monolítica R6 foi validado em `R6MonolithClearancePreview.tscn`, sem integração em módulos de produção. O preview confirmou que a baliza permanece aterrada na âncora canónica e que o proxy de percurso atravessa a rota sem bloquear durante a sessão QA.

| Critério | Resultado |
|---|---|
| Âncora da baliza | X/Z = `(52.00, 260.00)` |
| Corredor central | X = `60.00`, Z = `242.00`–`278.00` |
| Raio baliza + raio jogador | `1.40 + 0.55` |
| Folga calculada | `6.05 m` |
| Mínimo exigido | `4.00 m` |
| Grounding | `true` |
| Passagens completas | 2 ciclos, `clear=true` |
| Runtime | 36 segundos, encerramento controlado |
| Erros Dev5 após correcção | Nenhum `SCRIPT ERROR`, `Parse Error` ou erro de árvore |

A primeira execução detectou uma chamada a `global_position` antes da entrada do colisor na árvore. A correcção limitada ao preview substituiu-a por `position`, eliminando o erro sem alterar posição, raio, altura ou contrato de passagem. A execução final registou `monolith_grounded=true`, `clearance=6.05`, `route_cycle=1` e `route_cycle=2`. A advertência FSR1 permanece uma limitação conhecida do renderer Compatibility local e não afecta a validação geométrica.

> A aprovação confirma a segurança técnica da passagem QA. A captura visual final de R6 continua pendente de viewport gráfico válido.

## Evidência

O log final está em `CP-D5-042_R6_CLEARANCE_RUNTIME_FIXED.log`. O ficheiro modificado foi `levels/dev5/R6MonolithClearancePreview.gd`, dentro da fronteira Dev5.
