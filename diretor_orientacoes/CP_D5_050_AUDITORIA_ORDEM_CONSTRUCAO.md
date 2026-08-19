# CP-D5-050 — Auditoria de ordem de construção dos previews

## Resultado

A auditoria procurou atribuições de `global_position` em `levels/dev5/` e `entities/player/third_person/` que pudessem ocorrer antes da inserção do nó na árvore. Foram encontradas apenas as duas atribuições do `CartographicGroundingSystem.gd`; elas são intencionais e ocorrem sobre o candidato já recebido pelo método de grounding, depois de os previews o adicionarem à árvore.

| Área | Resultado |
|---|---|
| Atribuições suspeitas nos previews | 0 |
| Atribuições no sistema de grounding | 2, legítimas |
| Previews Elias com correcção de construção | R5 e R6 |
| Parser Compatibility | Sem `SCRIPT ERROR`, `Parse Error` ou falha de carregamento |
| Módulos de produção alterados | 0 |

As falhas históricas dos colisores R5/R6 foram corrigidas nos CP-D5-041 a CP-D5-049, substituindo `global_position` por `position` antes de `add_child()`. O log completo está em `CP-D5-050_CONSTRUCTION_ORDER_AUDIT.log`.

A auditoria não encontrou nova alteração necessária. O sistema de grounding continua autorizado a definir `candidate.global_position` porque recebe candidatos já instanciados na árvore e é precisamente o responsável por ajustar Y, preservando X/Z.
