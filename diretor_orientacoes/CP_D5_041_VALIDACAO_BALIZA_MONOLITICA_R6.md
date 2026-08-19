# CP-D5-041 — Validação da baliza monolítica R6

## Resultado

A baliza monolítica da Região 6 foi validada no preview isolado `SubmergedShoreMonolithPreview.tscn`, dentro do escopo permitido de Dev5. A cena executou a construção do terreno QA, o raycast de grounding e a apresentação da baliza durante uma sessão headless de 36 segundos.

| Critério | Resultado |
|---|---|
| Âncora cartográfica | Região 6, posição mundial X/Z = `(52.00, 260.00)` |
| Preservação de X/Z | `true` |
| Grounding | `true`; impacto Y = `-0.00` |
| Colisor atingido | `MargemR6ColisorQA` |
| Luzes dinâmicas adicionadas pelo candidato | `0` |
| Lajes de cais / colunas uniformes | `0 / 0` |
| Módulos de produção alterados | `false` |
| Sessão QA | 36 segundos, encerramento controlado por timeout |
| Parser/runtime Dev5 | Sem `SCRIPT ERROR`, `Parse Error` ou falha de instanciação observada |

O log de grounding contém a linha `[DEV5_R6_MONOLITH] ... grounded=true xz_preserved=true collider=MargemR6ColisorQA`, seguida de `status=approved`. O renderer local emitiu a advertência já conhecida de `FSR1` em Compatibility; ela não impediu a instanciação, o raycast, a validação nem a execução da sessão. Os logs completos estão em `CP-D5-041_R6_MONOLITH_RUNTIME.log` e `CP-D5-041_R6_MONOLITH_RUNTIME_36S.log`.

> Esta validação confirma a fundação técnica e cartográfica do candidato R6. Não constitui aprovação visual final de R6, que permanece pendente de captura gráfica válida no ambiente headless.

## Referências internas

[1]: `levels/dev5/SubmergedShoreMonolithPreview.gd` — implementação do preview e invariantes de grounding.
[2]: `levels/dev5/CartographicPlacementSystem.gd` — fonte dos anchors canónicos.
[3]: `levels/dev5/CartographicGroundingSystem.gd` — raycast e preservação de X/Z.
