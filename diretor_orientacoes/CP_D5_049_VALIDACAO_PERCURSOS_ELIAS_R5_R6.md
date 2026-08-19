# CP-D5-049 — Validação dos percursos Elias R5/R6

## Resultado

Os dois harnesses de percurso de Elias foram executados em sessões QA de 36 segundos. A prova confirma câmara externa proprietária, grounding dos marcos, folga mínima e dois ciclos completos sem bloqueio.

| Harness | Âncora | Percurso | Folga | Grounding | Câmara Elias | Ciclos |
|---|---|---|---:|---|---|---:|
| `EliasMajesticClearancePreview` | R5 `(-88,178)` | X = `-80` | `5,45 m` | `true` | `false` | 2 |
| `EliasR6ClearancePreview` | R6 `(52,260)` | X = `60` | `6,05 m` | `true` | `false` | 2 |

A primeira execução do harness R5 detectou a atribuição de `global_position` do colisor antes da inserção na árvore. O preview foi corrigido para usar `position`; a segunda sessão terminou sem `SCRIPT ERROR`, `Parse Error`, asserção ou erro de árvore. O R6 já mantinha a correcção equivalente. A advertência FSR1 do renderer Compatibility local não bloqueou a execução.

> O resultado aprova os percursos como evidência QA Dev5. Não autoriza integração automática em `Player.gd` ou nos módulos regionais; Dev1 continua proprietário da decisão de produção.

Os logs são `CP-D5-049_EliasMajesticClearancePreview_RUNTIME_FIXED.log` e `CP-D5-049_EliasR6ClearancePreview_RUNTIME.log`.
