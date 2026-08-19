# CP-D5-043 — Elias em terceira pessoa na margem R6

## Resultado

O preview `EliasR6ClearancePreview.tscn` valida a apresentação técnica de **Elias** em terceira pessoa junto à baliza monolítica R6, mantendo o actor isolado de `Player.gd` e dos módulos de produção. A cena combina o grounding cartográfico, o colisor da baliza e o trajecto central com a apresentação `EliasThirdPersonPresentation`.

| Critério | Resultado |
|---|---|
| Actor | `EliasActorQA` com `EliasThirdPersonPresentation` |
| Âncora da baliza | X/Z = `(52.00, 260.00)` |
| Corredor de Elias | X = `60.00` |
| Folga calculada | `6.05 m` |
| Mínimo exigido | `4.00 m` |
| Grounding | `true` |
| Percurso | 2 ciclos completos, `clear=true` |
| Player.gd alterado | Não |
| Sessão QA | 36 segundos |
| Erros Dev5 finais | Nenhum `SCRIPT ERROR`, `Parse Error` ou erro de árvore |

A primeira execução revelou a mesma condição de ordem da árvore já observada no preview de folga: `global_position` era consultada antes da entrada do colisor na árvore. A alteração limitada a `levels/dev5/EliasR6ClearancePreview.gd` substituiu a atribuição por `position`. A execução final confirmou `monolith_grounded=true`, `presentation=EliasThirdPersonPresentation`, dois ciclos de rota e folga de `6.05 m`. A mensagem FSR1 é uma advertência do renderer Compatibility local e não bloqueou a prova.

> A validação aprova a fundação técnica de terceira pessoa de Elias neste enquadramento QA. Não substitui o personagem artístico final nem autoriza a alteração de `Player.gd`.

## Evidência

O log final está em `CP-D5-043_ELIAS_R6_RUNTIME_FIXED.log`. O preview remoto original permanece documentado em `CP_D5_041_ELIAS_TERCEIRA_PESSOA_R6.md`.
